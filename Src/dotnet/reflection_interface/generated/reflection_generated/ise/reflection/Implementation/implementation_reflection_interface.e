indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.REFLECTION_INTERFACE"

external class
	IMPLEMENTATION_REFLECTION_INTERFACE

inherit
	REFLECTION_INTERFACE_SUPPORT
	REFLECTION_INTERFACE
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
			"IL creator use Implementation.REFLECTION_INTERFACE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_error_messages: REFLECTION_INTERFACE_ERROR_MESSAGES is
		external
			"IL field signature :REFLECTION_INTERFACE_ERROR_MESSAGES use Implementation.REFLECTION_INTERFACE"
		alias
			"$$error_messages"
		end

	frozen ec_illegal_36_ec_illegal_36_found: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.REFLECTION_INTERFACE"
		alias
			"$$found"
		end

	frozen ec_illegal_36_ec_illegal_36_last_error: ERROR_INFO is
		external
			"IL field signature :ERROR_INFO use Implementation.REFLECTION_INTERFACE"
		alias
			"$$last_error"
		end

	frozen ec_illegal_36_ec_illegal_36_last_read_successful: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.REFLECTION_INTERFACE"
		alias
			"$$last_read_successful"
		end

	frozen ec_illegal_36_ec_illegal_36_search_result: EIFFEL_ASSEMBLY is
		external
			"IL field signature :EIFFEL_ASSEMBLY use Implementation.REFLECTION_INTERFACE"
		alias
			"$$search_result"
		end

feature -- Basic Operations

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.REFLECTION_INTERFACE"
		alias
			"conforms_to"
		end

	assembly_version_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"assembly_version_element"
		end

	space: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"space"
		end

	precondition_tag_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"precondition_tag_element"
		end

	to_support_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"to_support_string"
		end

	to_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"to_component_string"
		end

	frozen ec_illegal_36_ec_illegal_36_support (current_: REFLECTION_INTERFACE): CODE_GENERATION_SUPPORT is
		external
			"IL static signature (REFLECTION_INTERFACE): CODE_GENERATION_SUPPORT use Implementation.REFLECTION_INTERFACE"
		alias
			"$$support"
		end

	select_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"select_element"
		end

	literal_value_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"literal_value_element"
		end

	feature_external_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"feature_external_name_element"
		end

	expanded_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"expanded_element"
		end

	parent_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"parent_element"
		end

	frozen_feature_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"frozen_feature_element"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.REFLECTION_INTERFACE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.REFLECTION_INTERFACE"
		alias
			"standard_equal"
		end

	precondition_text_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"precondition_text_element"
		end

	has_read_lock_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.REFLECTION_INTERFACE"
		alias
			"has_read_lock_code"
		end

	implementation_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"implementation_element"
		end

	invariants_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"invariants_element"
		end

	frozen ec_illegal_36_ec_illegal_36_has_write_lock_code (current_: REFLECTION_INTERFACE): INTEGER is
		external
			"IL static signature (REFLECTION_INTERFACE): System.Int32 use Implementation.REFLECTION_INTERFACE"
		alias
			"$$has_write_lock_code"
		end

	dtd_type_filename: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"dtd_type_filename"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.REFLECTION_INTERFACE"
		alias
			"same_type"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"out"
		end

	basic_operations_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"basic_operations_element"
		end

	simple_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"simple_name_element"
		end

	field_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"field_element"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_assembly (current_: REFLECTION_INTERFACE; a_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL static signature (REFLECTION_INTERFACE, ASSEMBLY_DESCRIPTOR): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"$$remove_assembly"
		end

	new_slot_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"new_slot_element"
		end

	last_read_successful: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.REFLECTION_INTERFACE"
		alias
			"last_read_successful"
		end

	assembly_descriptor_from_type (a_type: TYPE): ASSEMBLY_DESCRIPTOR is
		external
			"IL signature (System.Type): ASSEMBLY_DESCRIPTOR use Implementation.REFLECTION_INTERFACE"
		alias
			"assembly_descriptor_from_type"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"default_create"
		end

	has_write_lock_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.REFLECTION_INTERFACE"
		alias
			"has_write_lock_code"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.REFLECTION_INTERFACE"
		alias
			"io"
		end

	return_type_full_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"return_type_full_name_element"
		end

	return_type_generic_parameter_index_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"return_type_generic_parameter_index_element"
		end

	to_handler_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"to_handler_string"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.REFLECTION_INTERFACE"
		alias
			"standard_is_equal"
		end

	generic_parameter_index_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"generic_parameter_index_element"
		end

	static_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"static_element"
		end

	dot_string: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"dot_string"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_type (current_: REFLECTION_INTERFACE; xml_filename: STRING): EIFFEL_CLASS is
		external
			"IL static signature (REFLECTION_INTERFACE, STRING): EIFFEL_CLASS use Implementation.REFLECTION_INTERFACE"
		alias
			"$$eiffel_type"
		end

	a_set_found (found2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"_set_found"
		end

	assembly_culture_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"assembly_culture_element"
		end

	assemblies_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"assemblies_element"
		end

	true_string: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"true_string"
		end

	postcondition_text_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"postcondition_text_element"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.REFLECTION_INTERFACE"
		alias
			"deep_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.REFLECTION_INTERFACE"
		alias
			"operating_environment"
		end

	from_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"from_component_string"
		end

	index_filename: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"index_filename"
		end

	unary_operators_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"unary_operators_element"
		end

	argument_type_full_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"argument_type_full_name_element"
		end

	make_reflection_interface is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"make_reflection_interface"
		end

	search_result: EIFFEL_ASSEMBLY is
		external
			"IL signature (): EIFFEL_ASSEMBLY use Implementation.REFLECTION_INTERFACE"
		alias
			"search_result"
		end

	precondition_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"precondition_element"
		end

	remove_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"remove_assembly"
		end

	dash: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"dash"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.REFLECTION_INTERFACE"
		alias
			"default_pointer"
		end

	binary_operators_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"binary_operators_element"
		end

	frozen ec_illegal_36_ec_illegal_36_current_history (current_: REFLECTION_INTERFACE): HISTORY is
		external
			"IL static signature (REFLECTION_INTERFACE): HISTORY use Implementation.REFLECTION_INTERFACE"
		alias
			"$$current_history"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"default_rescue"
		end

	inherit_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"inherit_element"
		end

	header_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"header_element"
		end

	constraint_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"constraint_element"
		end

	from_handler_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"from_handler_string"
		end

	postcondition_tag_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"postcondition_tag_element"
		end

	frozen ec_illegal_36_ec_illegal_36_has_read_lock_code (current_: REFLECTION_INTERFACE): INTEGER is
		external
			"IL static signature (REFLECTION_INTERFACE): System.Int32 use Implementation.REFLECTION_INTERFACE"
		alias
			"$$has_read_lock_code"
		end

	generic_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"generic_element"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"tagged_out"
		end

	bit_or_infix_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"bit_or_infix_element"
		end

	body_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"body_element"
		end

	modified_feature_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"modified_feature_element"
		end

	frozen ec_illegal_36_ec_illegal_36_set_last_error (current_: REFLECTION_INTERFACE; an_error: ERROR_INFO) is
		external
			"IL static signature (REFLECTION_INTERFACE, ERROR_INFO): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"$$set_last_error"
		end

	namespace_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"namespace_element"
		end

	from_support_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"from_support_string"
		end

	frozen ec_illegal_36_ec_illegal_36_read_lock_creation_failed_code (current_: REFLECTION_INTERFACE): INTEGER is
		external
			"IL static signature (REFLECTION_INTERFACE): System.Int32 use Implementation.REFLECTION_INTERFACE"
		alias
			"$$read_lock_creation_failed_code"
		end

	assemblies: LINKED_LIST_ANY is
		external
			"IL signature (): LINKED_LIST_ANY use Implementation.REFLECTION_INTERFACE"
		alias
			"assemblies"
		end

	enum_literal_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"enum_literal_element"
		end

	invariant_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"invariant_element"
		end

	is_literal_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"is_literal_element"
		end

	generic_derivation_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"generic_derivation_element"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.REFLECTION_INTERFACE"
		alias
			"default"
		end

	postconditions_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"postconditions_element"
		end

	invariant_text_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"invariant_text_element"
		end

	derivation_types_count_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"derivation_types_count_element"
		end

	assembly_types_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"assembly_types_element"
		end

	preconditions_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"preconditions_element"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"deep_copy"
		end

	prefix_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"prefix_element"
		end

	false_string: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"false_string"
		end

	to_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"to_notifier_string"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.REFLECTION_INTERFACE"
		alias
			"____class_name"
		end

	redefine_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"redefine_element"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.REFLECTION_INTERFACE"
		alias
			"internal_clone"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"do_nothing"
		end

	a_set_search_result (search_result2: EIFFEL_ASSEMBLY) is
		external
			"IL signature (EIFFEL_ASSEMBLY): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"_set_search_result"
		end

	found: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.REFLECTION_INTERFACE"
		alias
			"found"
		end

	current_history: HISTORY is
		external
			"IL signature (): HISTORY use Implementation.REFLECTION_INTERFACE"
		alias
			"current_history"
		end

	abstract_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"abstract_element"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.REFLECTION_INTERFACE"
		alias
			"clone"
		end

	from_system_string (string: SYSTEM_STRING): STRING is
		external
			"IL signature (System.String): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"from_system_string"
		end

	method_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"method_element"
		end

	postcondition_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"postcondition_element"
		end

	initialization_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"initialization_element"
		end

	access_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"access_element"
		end

	invariant_tag_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"invariant_tag_element"
		end

	generic_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"generic_type_element"
		end

	class_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"class_element"
		end

	enum_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"enum_type_element"
		end

	modified_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"modified_element"
		end

	specials_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"specials_element"
		end

	alias_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"alias_element"
		end

	create_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"create_element"
		end

	generic_type_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"generic_type_eiffel_name_element"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.REFLECTION_INTERFACE"
		alias
			"ToString"
		end

	assembly_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"assembly_name_element"
		end

	parent_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"parent_name_element"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.REFLECTION_INTERFACE"
		alias
			"Equals"
		end

	empty_string: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"empty_string"
		end

	return_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"return_type_element"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_descriptor_from_type (current_: REFLECTION_INTERFACE; a_type: TYPE): ASSEMBLY_DESCRIPTOR is
		external
			"IL static signature (REFLECTION_INTERFACE, System.Type): ASSEMBLY_DESCRIPTOR use Implementation.REFLECTION_INTERFACE"
		alias
			"$$assembly_descriptor_from_type"
		end

	from_generator_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"from_generator_string"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.REFLECTION_INTERFACE"
		alias
			"standard_clone"
		end

	to_generator_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"to_generator_string"
		end

	a_set_last_read_successful (last_read_successful2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"_set_last_read_successful"
		end

	generic_type_external_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"generic_type_external_name_element"
		end

	export_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"export_element"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_assembly (current_: REFLECTION_INTERFACE; xml_filename: STRING): EIFFEL_ASSEMBLY is
		external
			"IL static signature (REFLECTION_INTERFACE, STRING): EIFFEL_ASSEMBLY use Implementation.REFLECTION_INTERFACE"
		alias
			"$$eiffel_assembly"
		end

	constraints_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"constraints_element"
		end

	a_set_error_messages (error_messages2: REFLECTION_INTERFACE_ERROR_MESSAGES) is
		external
			"IL signature (REFLECTION_INTERFACE_ERROR_MESSAGES): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"_set_error_messages"
		end

	feature_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"feature_eiffel_name_element"
		end

	footer_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"footer_element"
		end

	frozen ec_illegal_36_ec_illegal_36_assemblies (current_: REFLECTION_INTERFACE): LINKED_LIST_ANY is
		external
			"IL static signature (REFLECTION_INTERFACE): LINKED_LIST_ANY use Implementation.REFLECTION_INTERFACE"
		alias
			"$$assemblies"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.REFLECTION_INTERFACE"
		alias
			"deep_equal"
		end

	error_messages: REFLECTION_INTERFACE_ERROR_MESSAGES is
		external
			"IL signature (): REFLECTION_INTERFACE_ERROR_MESSAGES use Implementation.REFLECTION_INTERFACE"
		alias
			"error_messages"
		end

	frozen ec_illegal_36_ec_illegal_36_search (current_: REFLECTION_INTERFACE; a_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL static signature (REFLECTION_INTERFACE, ASSEMBLY_DESCRIPTOR): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"$$search"
		end

	search (a_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"search"
		end

	assembly_public_key_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"assembly_public_key_element"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"standard_copy"
		end

	xml_extension: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"xml_extension"
		end

	rename_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"rename_element"
		end

	argument_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"argument_eiffel_name_element"
		end

	support: CODE_GENERATION_SUPPORT is
		external
			"IL signature (): CODE_GENERATION_SUPPORT use Implementation.REFLECTION_INTERFACE"
		alias
			"support"
		end

	type (a_type: TYPE): EIFFEL_CLASS is
		external
			"IL signature (System.Type): EIFFEL_CLASS use Implementation.REFLECTION_INTERFACE"
		alias
			"type"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.REFLECTION_INTERFACE"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_make_reflection_interface (current_: REFLECTION_INTERFACE) is
		external
			"IL static signature (REFLECTION_INTERFACE): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"$$make_reflection_interface"
		end

	a_set_last_error (last_error2: ERROR_INFO) is
		external
			"IL signature (ERROR_INFO): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"_set_last_error"
		end

	frozen_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"frozen_element"
		end

	assembly_type_filename_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"assembly_type_filename_element"
		end

	assembly_filename_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"assembly_filename_element"
		end

	last_error: ERROR_INFO is
		external
			"IL signature (): ERROR_INFO use Implementation.REFLECTION_INTERFACE"
		alias
			"last_error"
		end

	from_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"from_notifier_string"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.REFLECTION_INTERFACE"
		alias
			"equal"
		end

	undefine_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"undefine_element"
		end

	frozen ec_illegal_36_ec_illegal_36_type (current_: REFLECTION_INTERFACE; a_type: TYPE): EIFFEL_CLASS is
		external
			"IL static signature (REFLECTION_INTERFACE, System.Type): EIFFEL_CLASS use Implementation.REFLECTION_INTERFACE"
		alias
			"$$type"
		end

	feature_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"feature_element"
		end

	comments_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"comments_element"
		end

	class_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"class_eiffel_name_element"
		end

	create_none_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"create_none_element"
		end

	dtd_extension: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"dtd_extension"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"generating_type"
		end

	argument_external_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"argument_external_name_element"
		end

	eiffel_assembly (xml_filename: STRING): EIFFEL_ASSEMBLY is
		external
			"IL signature (STRING): EIFFEL_ASSEMBLY use Implementation.REFLECTION_INTERFACE"
		alias
			"eiffel_assembly"
		end

	emitter_version_number_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"emitter_version_number_element"
		end

	infix_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"infix_element"
		end

	eiffel_cluster_path_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"eiffel_cluster_path_element"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly (current_: REFLECTION_INTERFACE; a_descriptor: ASSEMBLY_DESCRIPTOR): EIFFEL_ASSEMBLY is
		external
			"IL static signature (REFLECTION_INTERFACE, ASSEMBLY_DESCRIPTOR): EIFFEL_ASSEMBLY use Implementation.REFLECTION_INTERFACE"
		alias
			"$$assembly"
		end

	set_last_error (an_error: ERROR_INFO) is
		external
			"IL signature (ERROR_INFO): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"set_last_error"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"print"
		end

	read_lock_creation_failed_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.REFLECTION_INTERFACE"
		alias
			"read_lock_creation_failed_code"
		end

	element_change_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"element_change_element"
		end

	eiffel_type (xml_filename: STRING): EIFFEL_CLASS is
		external
			"IL signature (STRING): EIFFEL_CLASS use Implementation.REFLECTION_INTERFACE"
		alias
			"eiffel_type"
		end

	generic_derivations_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"generic_derivations_element"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"copy"
		end

	assembly (a_descriptor: ASSEMBLY_DESCRIPTOR): EIFFEL_ASSEMBLY is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR): EIFFEL_ASSEMBLY use Implementation.REFLECTION_INTERFACE"
		alias
			"assembly"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"internal_copy"
		end

	argument_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"argument_element"
		end

	comma: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"comma"
		end

	deferred_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"deferred_element"
		end

	arguments_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"arguments_element"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"generator"
		end

	creation_routine_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"creation_routine_element"
		end

	argument_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"argument_type_element"
		end

	assembly_element: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"assembly_element"
		end

	dtd_assembly_filename: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE"
		alias
			"dtd_assembly_filename"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_INTERFACE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_REFLECTION_INTERFACE
