/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMPILER_COMPILER_PROXY_H__
#define __ECOM_EIFFELCOMPILER_COMPILER_PROXY_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelCompiler
{
class COMPILER_PROXY;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelCompiler_COMPILER_PROXY_I.h"

#include "ecom_grt_globals_compiler_c.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelCompiler
{
class COMPILER_PROXY
{
public:
	COMPILER_PROXY ();
	COMPILER_PROXY (IUnknown * a_pointer);
	virtual ~COMPILER_PROXY ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_console_application();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_window_application();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_dll();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_version(  /* [in] */ EIF_INTEGER build,  /* [in] */ EIF_INTEGER major,  /* [in] */ EIF_INTEGER minor,  /* [in] */ EIF_INTEGER revision );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_verifiability(  /* [in] */ EIF_BOOLEAN v );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_cls_compliant(  /* [in] */ EIF_BOOLEAN v );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_any_type_id(  /* [in] */ EIF_INTEGER v );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_start_assembly_generation(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_OBJECT fname,  /* [in] */ EIF_OBJECT location );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_assembly_reference(  /* [in] */ EIF_OBJECT name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_start_module_generation(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_BOOLEAN debug1 );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_end_assembly_generation();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_start_class_mappings(  /* [in] */ EIF_INTEGER class_count );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_class_mappings(  /* [in] */ EIF_OBJECT dotnet_name,  /* [in] */ EIF_OBJECT eiffel_name,  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER interface_id,  /* [in] */ EIF_OBJECT source_file_name,  /* [in] */ EIF_OBJECT element_type_name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_type_class_mapping(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_class_type_class_mapping(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_generic_type_class_mapping(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_formal_type_class_mapping(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_none_type_class_mapping(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_basic_type_class_mapping(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_eiffel_type_info_type_class_mapping(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_class_header(  /* [in] */ EIF_BOOLEAN is_interface,  /* [in] */ EIF_BOOLEAN is_deferred,  /* [in] */ EIF_BOOLEAN is_frozen,  /* [in] */ EIF_BOOLEAN is_expanded,  /* [in] */ EIF_BOOLEAN is_external,  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_end_class();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_to_parents_list(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_interface(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_implementation_class();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_end_parents_list();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_start_features_list(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_mark_invariant(  /* [in] */ EIF_INTEGER feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_mark_creation_routines(  /* [in] */ EIF_OBJECT feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_start_feature_description(  /* [in] */ EIF_INTEGER arg_count );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_interface_feature_identification(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_INTEGER feature_id,  /* [in] */ EIF_BOOLEAN is_attribute );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_feature_identification(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_INTEGER feature_id,  /* [in] */ EIF_BOOLEAN is_redefined,  /* [in] */ EIF_BOOLEAN is_deferred,  /* [in] */ EIF_BOOLEAN is_frozen,  /* [in] */ EIF_BOOLEAN is_attribute,  /* [in] */ EIF_BOOLEAN is_c_external,  /* [in] */ EIF_BOOLEAN is_static );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_external_identification(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_OBJECT com_name,  /* [in] */ EIF_INTEGER external_kind,  /* [in] */ EIF_INTEGER feature_id,  /* [in] */ EIF_INTEGER routine_id,  /* [in] */ EIF_BOOLEAN in_current_class,  /* [in] */ EIF_INTEGER written_type_id,  /* [in] */ EIF_OBJECT parameters,  /* [in] */ EIF_OBJECT return_type );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_feature_return_type(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_feature_argument(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_create_feature_description();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_define_entry_point(  /* [in] */ EIF_INTEGER creation_type_id,  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_ca(  /* [in] */ EIF_INTEGER target_type_id,  /* [in] */ EIF_INTEGER attribute_type_id,  /* [in] */ EIF_INTEGER arg_count );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_class_ca();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_feature_ca(  /* [in] */ EIF_INTEGER feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_catyped_arg(  /* [in] */ EIF_INTEGER a_value,  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_cainteger_arg(  /* [in] */ EIF_INTEGER a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_castring_arg(  /* [in] */ EIF_OBJECT a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_careal_arg(  /* [in] */ EIF_DOUBLE a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_cadouble_arg(  /* [in] */ EIF_DOUBLE a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_cacharacter_arg(  /* [in] */ EIF_INTEGER a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_caboolean_arg(  /* [in] */ EIF_BOOLEAN a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_caarray_integer_arg(  /* [in] */ EIF_OBJECT a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_caarray_string_arg(  /* [in] */ EIF_OBJECT a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_caarray_real_arg(  /* [in] */ EIF_OBJECT a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_caarray_double_arg(  /* [in] */ EIF_OBJECT a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_caarray_character_arg(  /* [in] */ EIF_OBJECT a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_caarray_boolean_arg(  /* [in] */ EIF_OBJECT a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_start_il_generation(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_type_feature(  /* [in] */ EIF_INTEGER feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_feature_il(  /* [in] */ EIF_INTEGER feature_id,  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER code_feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_feature_internal_clone(  /* [in] */ EIF_INTEGER feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_implementation_feature_il(  /* [in] */ EIF_INTEGER feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_method_impl(  /* [in] */ EIF_INTEGER feature_id,  /* [in] */ EIF_INTEGER parent_type_id,  /* [in] */ EIF_INTEGER parent_feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_creation_feature_il(  /* [in] */ EIF_INTEGER feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_external_call(  /* [in] */ EIF_OBJECT external_type_name,  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_INTEGER external_kind,  /* [in] */ EIF_OBJECT parameter_types,  /* [in] */ EIF_OBJECT return_type,  /* [in] */ EIF_BOOLEAN is_virtual );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_put_result_info(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_put_local_info(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_OBJECT name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_create_like_current_object();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_create_object(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_create_attribute_object(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_duplicate_top();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_pop();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_metamorphose(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_unmetamorphose(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_check_cast(  /* [in] */ EIF_INTEGER source_type_id,  /* [in] */ EIF_INTEGER target_type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_convert_to_native_int();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_convert_to_boolean();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_convert_to_character();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_convert_to_integer8();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_convert_to_integer16();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_convert_to_integer32();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_convert_to_integer64();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_convert_to_double();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_convert_to_real();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_current();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_result();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_attribute(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_feature_access(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id,  /* [in] */ EIF_BOOLEAN is_virtual );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_precursor_feature_access(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_put_method_token(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_put_type_token(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_argument(  /* [in] */ EIF_INTEGER n );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_local(  /* [in] */ EIF_INTEGER n );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_in_assertion_test(  /* [in] */ EIF_INTEGER end_of_assert_label );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_set_assertion_status();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_restore_assertion_status();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_assertion_check(  /* [in] */ EIF_INTEGER assert_type,  /* [in] */ EIF_OBJECT tag );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_precondition_check(  /* [in] */ EIF_OBJECT tag,  /* [in] */ EIF_INTEGER label_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_precondition_violation();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_invariant_checking(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_start_exception_block();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_start_rescue();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_end_exception_block();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_is_instance_of(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_attribute_assignment(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_local_assignment(  /* [in] */ EIF_INTEGER n );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_result_assignment();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_local_address(  /* [in] */ EIF_INTEGER n );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_routine_address(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_result_address();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_current_address();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_attribute_address(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_argument_address(  /* [in] */ EIF_INTEGER n );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_load_from_address(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_array_access(  /* [in] */ EIF_INTEGER kind );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_array_write(  /* [in] */ EIF_INTEGER kind );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_array_creation(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_return();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_once_done_info(  /* [in] */ EIF_OBJECT name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_once_result_info(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_once_computed();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_once_result_address();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_once_test();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_once_result();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_once_store_result();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_array_lower();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_array_upper();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_array_count();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_put_void();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_put_manifest_string(  /* [in] */ EIF_OBJECT s );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_put_integer8_constant(  /* [in] */ EIF_INTEGER i );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_put_integer16_constant(  /* [in] */ EIF_INTEGER i );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_put_integer32_constant(  /* [in] */ EIF_INTEGER i );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_put_integer64_constant(  /* [in] */ EIF_INTEGER_64 i );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_put_double_constant(  /* [in] */ EIF_DOUBLE d );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_put_real_constant(  /* [in] */ EIF_DOUBLE d );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_put_character_constant(  /* [in] */ EIF_INTEGER c );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_put_boolean_constant(  /* [in] */ EIF_BOOLEAN b );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_branch_on_true(  /* [in] */ EIF_INTEGER label );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_branch_on_false(  /* [in] */ EIF_INTEGER label );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_branch_to(  /* [in] */ EIF_INTEGER label );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_mark_label(  /* [in] */ EIF_INTEGER label );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_lt();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_le();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_gt();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_ge();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_star();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_power();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_max(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_min(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_abs(  /* [in] */ EIF_INTEGER type_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_to_string();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_plus();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_mod();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_minus();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_div();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_xor();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_or();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_and();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_implies();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_eq();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_shl();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_shr();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_ne();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_uminus();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_not();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_bitwise_not();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_put_line_info(  /* [in] */ EIF_INTEGER line_number,  /* [in] */ EIF_INTEGER start_column,  /* [in] */ EIF_INTEGER end_column );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_create_label(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_for_interfaces();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_for_implementations();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_EiffelCompiler::COMPILER_PROXY_I * p_COMPILER_PROXY_I;


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
#include "ecom_grt_globals_compiler_c.h"


#endif