indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.XML_ELEMENTS"

external class
	IMPLEMENTATION_XML_ELEMENTS

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	XML_ELEMENTS
	DICTIONARY

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.XML_ELEMENTS"
		end

feature -- Basic Operations

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.XML_ELEMENTS"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$assembly_element"
		end

	frozen ec_illegal_36_ec_illegal_36_postcondition_text_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$postcondition_text_element"
		end

	frozen ec_illegal_36_ec_illegal_36_invariant_text_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$invariant_text_element"
		end

	frozen ec_illegal_36_ec_illegal_36_prefix_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$prefix_element"
		end

	frozen ec_illegal_36_ec_illegal_36_constraint_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$constraint_element"
		end

	select_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"select_element"
		end

	literal_value_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"literal_value_element"
		end

	feature_external_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"feature_external_name_element"
		end

	expanded_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"expanded_element"
		end

	parent_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"parent_element"
		end

	frozen_feature_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"frozen_feature_element"
		end

	frozen ec_illegal_36_ec_illegal_36_expanded_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$expanded_element"
		end

	frozen ec_illegal_36_ec_illegal_36_literal_value_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$literal_value_element"
		end

	frozen ec_illegal_36_ec_illegal_36_generic_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$generic_element"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.XML_ELEMENTS"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_is_literal_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$is_literal_element"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.XML_ELEMENTS"
		alias
			"standard_equal"
		end

	precondition_text_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"precondition_text_element"
		end

	frozen ec_illegal_36_ec_illegal_36_create_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$create_element"
		end

	implementation_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"implementation_element"
		end

	invariants_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"invariants_element"
		end

	dtd_type_filename: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"dtd_type_filename"
		end

	frozen ec_illegal_36_ec_illegal_36_frozen_feature_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$frozen_feature_element"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.XML_ELEMENTS"
		alias
			"same_type"
		end

	simple_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"simple_name_element"
		end

	field_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"field_element"
		end

	frozen ec_illegal_36_ec_illegal_36_feature_eiffel_name_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$feature_eiffel_name_element"
		end

	new_slot_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"new_slot_element"
		end

	frozen ec_illegal_36_ec_illegal_36_precondition_text_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$precondition_text_element"
		end

	assembly_version_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"assembly_version_element"
		end

	frozen ec_illegal_36_ec_illegal_36_postcondition_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$postcondition_element"
		end

	basic_operations_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"basic_operations_element"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.XML_ELEMENTS"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_inherit_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$inherit_element"
		end

	return_type_full_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"return_type_full_name_element"
		end

	frozen ec_illegal_36_ec_illegal_36_parent_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$parent_element"
		end

	return_type_generic_parameter_index_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"return_type_generic_parameter_index_element"
		end

	generic_derivation_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"generic_derivation_element"
		end

	frozen ec_illegal_36_ec_illegal_36_return_type_full_name_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$return_type_full_name_element"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.XML_ELEMENTS"
		alias
			"standard_is_equal"
		end

	generic_parameter_index_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"generic_parameter_index_element"
		end

	static_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"static_element"
		end

	frozen ec_illegal_36_ec_illegal_36_return_type_generic_parameter_index_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$return_type_generic_parameter_index_element"
		end

	dot_string: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"dot_string"
		end

	assembly_culture_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"assembly_culture_element"
		end

	assemblies_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"assemblies_element"
		end

	true_string: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"true_string"
		end

	frozen ec_illegal_36_ec_illegal_36_precondition_tag_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$precondition_tag_element"
		end

	frozen ec_illegal_36_ec_illegal_36_rename_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$rename_element"
		end

	postcondition_text_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"postcondition_text_element"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.XML_ELEMENTS"
		alias
			"operating_environment"
		end

	frozen ec_illegal_36_ec_illegal_36_class_eiffel_name_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$class_eiffel_name_element"
		end

	frozen ec_illegal_36_ec_illegal_36_assemblies_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$assemblies_element"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.XML_ELEMENTS"
		alias
			"____class_name"
		end

	index_filename: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"index_filename"
		end

	unary_operators_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"unary_operators_element"
		end

	argument_type_full_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"argument_type_full_name_element"
		end

	frozen ec_illegal_36_ec_illegal_36_generic_parameter_index_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$generic_parameter_index_element"
		end

	frozen ec_illegal_36_ec_illegal_36_arguments_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$arguments_element"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_type_filename_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$assembly_type_filename_element"
		end

	frozen ec_illegal_36_ec_illegal_36_namespace_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$namespace_element"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_cluster_path_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$eiffel_cluster_path_element"
		end

	frozen ec_illegal_36_ec_illegal_36_invariant_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$invariant_element"
		end

	precondition_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"precondition_element"
		end

	precondition_tag_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"precondition_tag_element"
		end

	dash: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"dash"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.XML_ELEMENTS"
		alias
			"default_pointer"
		end

	binary_operators_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"binary_operators_element"
		end

	frozen ec_illegal_36_ec_illegal_36_argument_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$argument_element"
		end

	frozen ec_illegal_36_ec_illegal_36_element_change_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$element_change_element"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.XML_ELEMENTS"
		alias
			"default_rescue"
		end

	inherit_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"inherit_element"
		end

	header_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"header_element"
		end

	frozen ec_illegal_36_ec_illegal_36_generic_derivations_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$generic_derivations_element"
		end

	generic_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"generic_element"
		end

	frozen ec_illegal_36_ec_illegal_36_deferred_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$deferred_element"
		end

	postcondition_tag_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"postcondition_tag_element"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"tagged_out"
		end

	bit_or_infix_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"bit_or_infix_element"
		end

	body_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"body_element"
		end

	frozen ec_illegal_36_ec_illegal_36_preconditions_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$preconditions_element"
		end

	modified_feature_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"modified_feature_element"
		end

	namespace_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"namespace_element"
		end

	frozen ec_illegal_36_ec_illegal_36_parent_name_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$parent_name_element"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.XML_ELEMENTS"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_postcondition_tag_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$postcondition_tag_element"
		end

	enum_literal_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"enum_literal_element"
		end

	invariant_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"invariant_element"
		end

	is_literal_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"is_literal_element"
		end

	space: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"space"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.XML_ELEMENTS"
		alias
			"default"
		end

	postconditions_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"postconditions_element"
		end

	frozen ec_illegal_36_ec_illegal_36_feature_external_name_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$feature_external_name_element"
		end

	invariant_text_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"invariant_text_element"
		end

	derivation_types_count_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"derivation_types_count_element"
		end

	frozen ec_illegal_36_ec_illegal_36_modified_feature_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$modified_feature_element"
		end

	assembly_types_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"assembly_types_element"
		end

	preconditions_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"preconditions_element"
		end

	frozen ec_illegal_36_ec_illegal_36_constraints_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$constraints_element"
		end

	frozen ec_illegal_36_ec_illegal_36_static_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$static_element"
		end

	frozen ec_illegal_36_ec_illegal_36_method_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$method_element"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.XML_ELEMENTS"
		alias
			"deep_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_alias_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$alias_element"
		end

	prefix_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"prefix_element"
		end

	frozen ec_illegal_36_ec_illegal_36_invariant_tag_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$invariant_tag_element"
		end

	false_string: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"false_string"
		end

	frozen ec_illegal_36_ec_illegal_36_specials_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$specials_element"
		end

	redefine_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"redefine_element"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_name_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$assembly_name_element"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.XML_ELEMENTS"
		alias
			"internal_clone"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.XML_ELEMENTS"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_redefine_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$redefine_element"
		end

	frozen ec_illegal_36_ec_illegal_36_body_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$body_element"
		end

	alias_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"alias_element"
		end

	frozen ec_illegal_36_ec_illegal_36_frozen_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$frozen_element"
		end

	abstract_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"abstract_element"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.XML_ELEMENTS"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_select_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$select_element"
		end

	method_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"method_element"
		end

	postcondition_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"postcondition_element"
		end

	initialization_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"initialization_element"
		end

	access_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"access_element"
		end

	invariant_tag_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"invariant_tag_element"
		end

	frozen ec_illegal_36_ec_illegal_36_new_slot_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$new_slot_element"
		end

	generic_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"generic_type_element"
		end

	class_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"class_element"
		end

	enum_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"enum_type_element"
		end

	modified_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"modified_element"
		end

	specials_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"specials_element"
		end

	assembly_public_key_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"assembly_public_key_element"
		end

	create_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"create_element"
		end

	generic_type_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"generic_type_eiffel_name_element"
		end

	frozen ec_illegal_36_ec_illegal_36_derivation_types_count_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$derivation_types_count_element"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.XML_ELEMENTS"
		alias
			"ToString"
		end

	assembly_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"assembly_name_element"
		end

	frozen ec_illegal_36_ec_illegal_36_modified_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$modified_element"
		end

	frozen ec_illegal_36_ec_illegal_36_creation_routine_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$creation_routine_element"
		end

	frozen ec_illegal_36_ec_illegal_36_argument_external_name_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$argument_external_name_element"
		end

	parent_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"parent_name_element"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.XML_ELEMENTS"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_feature_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$feature_element"
		end

	empty_string: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"empty_string"
		end

	return_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"return_type_element"
		end

	frozen ec_illegal_36_ec_illegal_36_create_none_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$create_none_element"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"out"
		end

	frozen ec_illegal_36_ec_illegal_36_enum_type_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$enum_type_element"
		end

	generic_type_external_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"generic_type_external_name_element"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_public_key_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$assembly_public_key_element"
		end

	export_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"export_element"
		end

	frozen ec_illegal_36_ec_illegal_36_abstract_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$abstract_element"
		end

	constraints_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"constraints_element"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_types_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$assembly_types_element"
		end

	feature_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"feature_eiffel_name_element"
		end

	footer_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"footer_element"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.XML_ELEMENTS"
		alias
			"deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_emitter_version_number_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$emitter_version_number_element"
		end

	frozen ec_illegal_36_ec_illegal_36_argument_type_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$argument_type_element"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.XML_ELEMENTS"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_bit_or_infix_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$bit_or_infix_element"
		end

	xml_extension: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"xml_extension"
		end

	constraint_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"constraint_element"
		end

	rename_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"rename_element"
		end

	argument_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"argument_eiffel_name_element"
		end

	frozen ec_illegal_36_ec_illegal_36_invariants_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$invariants_element"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.XML_ELEMENTS"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_enum_literal_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$enum_literal_element"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.XML_ELEMENTS"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_unary_operators_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$unary_operators_element"
		end

	frozen ec_illegal_36_ec_illegal_36_initialization_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$initialization_element"
		end

	frozen_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"frozen_element"
		end

	frozen ec_illegal_36_ec_illegal_36_export_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$export_element"
		end

	assembly_type_filename_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"assembly_type_filename_element"
		end

	assembly_filename_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"assembly_filename_element"
		end

	frozen ec_illegal_36_ec_illegal_36_comments_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$comments_element"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_version_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$assembly_version_element"
		end

	frozen ec_illegal_36_ec_illegal_36_basic_operations_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$basic_operations_element"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.XML_ELEMENTS"
		alias
			"equal"
		end

	undefine_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"undefine_element"
		end

	frozen ec_illegal_36_ec_illegal_36_argument_type_full_name_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$argument_type_full_name_element"
		end

	feature_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"feature_element"
		end

	comments_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"comments_element"
		end

	frozen ec_illegal_36_ec_illegal_36_undefine_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$undefine_element"
		end

	class_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"class_eiffel_name_element"
		end

	frozen ec_illegal_36_ec_illegal_36_infix_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$infix_element"
		end

	create_none_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"create_none_element"
		end

	frozen ec_illegal_36_ec_illegal_36_footer_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$footer_element"
		end

	dtd_extension: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"dtd_extension"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_access_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$access_element"
		end

	frozen ec_illegal_36_ec_illegal_36_generic_type_external_name_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$generic_type_external_name_element"
		end

	argument_external_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"argument_external_name_element"
		end

	frozen ec_illegal_36_ec_illegal_36_precondition_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$precondition_element"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_culture_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$assembly_culture_element"
		end

	frozen ec_illegal_36_ec_illegal_36_simple_name_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$simple_name_element"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_filename_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$assembly_filename_element"
		end

	emitter_version_number_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"emitter_version_number_element"
		end

	infix_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"infix_element"
		end

	frozen ec_illegal_36_ec_illegal_36_header_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$header_element"
		end

	eiffel_cluster_path_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"eiffel_cluster_path_element"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.XML_ELEMENTS"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.XML_ELEMENTS"
		alias
			"print"
		end

	element_change_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"element_change_element"
		end

	frozen ec_illegal_36_ec_illegal_36_generic_derivation_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$generic_derivation_element"
		end

	frozen ec_illegal_36_ec_illegal_36_class_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$class_element"
		end

	frozen ec_illegal_36_ec_illegal_36_argument_eiffel_name_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$argument_eiffel_name_element"
		end

	generic_derivations_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"generic_derivations_element"
		end

	frozen ec_illegal_36_ec_illegal_36_field_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$field_element"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.XML_ELEMENTS"
		alias
			"copy"
		end

	frozen ec_illegal_36_ec_illegal_36_postconditions_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$postconditions_element"
		end

	frozen ec_illegal_36_ec_illegal_36_return_type_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$return_type_element"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.XML_ELEMENTS"
		alias
			"internal_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_implementation_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$implementation_element"
		end

	argument_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"argument_element"
		end

	frozen ec_illegal_36_ec_illegal_36_generic_type_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$generic_type_element"
		end

	frozen ec_illegal_36_ec_illegal_36_binary_operators_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$binary_operators_element"
		end

	frozen ec_illegal_36_ec_illegal_36_generic_type_eiffel_name_element (current_: XML_ELEMENTS): STRING is
		external
			"IL static signature (XML_ELEMENTS): STRING use Implementation.XML_ELEMENTS"
		alias
			"$$generic_type_eiffel_name_element"
		end

	comma: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"comma"
		end

	deferred_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"deferred_element"
		end

	arguments_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"arguments_element"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"generator"
		end

	creation_routine_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"creation_routine_element"
		end

	argument_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"argument_type_element"
		end

	assembly_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"assembly_element"
		end

	dtd_assembly_filename: STRING is
		external
			"IL signature (): STRING use Implementation.XML_ELEMENTS"
		alias
			"dtd_assembly_filename"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.XML_ELEMENTS"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_XML_ELEMENTS
