indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"

external class
	IMPLEMENTATION_EIFFEL_ASSEMBLY_CACHE_HANDLER

inherit
	DICTIONARY
	EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	EIFFEL_ASSEMBLY_CACHE_HANDLER
	XML_ELEMENTS

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_last_removal_successful: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$last_removal_successful"
		end

	frozen ec_illegal_36_ec_illegal_36_error_messages: EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES is
		external
			"IL field signature :EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$error_messages"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_descriptor: ASSEMBLY_DESCRIPTOR is
		external
			"IL field signature :ASSEMBLY_DESCRIPTOR use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$assembly_descriptor"
		end

	frozen ec_illegal_36_ec_illegal_36_last_write_successful: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$last_write_successful"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_assembly: EIFFEL_ASSEMBLY is
		external
			"IL field signature :EIFFEL_ASSEMBLY use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$eiffel_assembly"
		end

	frozen ec_illegal_36_ec_illegal_36_last_error: ERROR_INFO is
		external
			"IL field signature :ERROR_INFO use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$last_error"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_folder_path: STRING is
		external
			"IL field signature :STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$assembly_folder_path"
		end

feature -- Basic Operations

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"conforms_to"
		end

	assembly_version_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"assembly_version_element"
		end

	frozen ec_illegal_36_ec_illegal_36_store_assembly (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER; an_eiffel_assembly: EIFFEL_ASSEMBLY): TYPE_STORER is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER, EIFFEL_ASSEMBLY): TYPE_STORER use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$store_assembly"
		end

	space: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"space"
		end

	precondition_tag_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"precondition_tag_element"
		end

	to_support_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"to_support_string"
		end

	to_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"to_component_string"
		end

	frozen ec_illegal_36_ec_illegal_36_support (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER): CODE_GENERATION_SUPPORT is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER): CODE_GENERATION_SUPPORT use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$support"
		end

	select_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"select_element"
		end

	literal_value_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"literal_value_element"
		end

	feature_external_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"feature_external_name_element"
		end

	frozen ec_illegal_36_ec_illegal_36_prepare_assembly_storage (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$prepare_assembly_storage"
		end

	expanded_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"expanded_element"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_assembly_xml_file (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$generate_assembly_xml_file"
		end

	parent_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"parent_element"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"clone"
		end

	frozen_feature_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"frozen_feature_element"
		end

	assembly_folder_path: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"assembly_folder_path"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"is_equal"
		end

	precondition_text_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"precondition_text_element"
		end

	has_read_lock_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"has_read_lock_code"
		end

	implementation_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"implementation_element"
		end

	invariants_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"invariants_element"
		end

	frozen ec_illegal_36_ec_illegal_36_has_write_lock_code (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER): INTEGER is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER): System.Int32 use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$has_write_lock_code"
		end

	dtd_type_filename: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"dtd_type_filename"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"same_type"
		end

	from_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"from_component_string"
		end

	basic_operations_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"basic_operations_element"
		end

	simple_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"simple_name_element"
		end

	frozen ec_illegal_36_ec_illegal_36_write_lock_creation_failed_code (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER): INTEGER is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER): System.Int32 use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$write_lock_creation_failed_code"
		end

	field_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"field_element"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"GetHashCode"
		end

	a_set_last_removal_successful (last_removal_successful2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"_set_last_removal_successful"
		end

	new_slot_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"new_slot_element"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"default_create"
		end

	has_write_lock_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"has_write_lock_code"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_access_violation_error (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER): STRING is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$access_violation_error"
		end

	return_type_full_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"return_type_full_name_element"
		end

	return_type_generic_parameter_index_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"return_type_generic_parameter_index_element"
		end

	frozen ec_illegal_36_ec_illegal_36_type_storer_from_class (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER; an_eiffel_class: EIFFEL_CLASS): TYPE_STORER is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER, EIFFEL_CLASS): TYPE_STORER use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$type_storer_from_class"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"standard_is_equal"
		end

	generic_parameter_index_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"generic_parameter_index_element"
		end

	static_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"static_element"
		end

	is_valid_directory_path (a_folder_name: STRING): BOOLEAN is
		external
			"IL signature (STRING): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"is_valid_directory_path"
		end

	dot_string: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"dot_string"
		end

	assembly_culture_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"assembly_culture_element"
		end

	assembly_types_from_xml (xml_filename: STRING): LINKED_LIST_ANY is
		external
			"IL signature (STRING): LINKED_LIST_ANY use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"assembly_types_from_xml"
		end

	assemblies_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"assemblies_element"
		end

	true_string: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"true_string"
		end

	to_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"to_notifier_string"
		end

	postcondition_text_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"postcondition_text_element"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"operating_environment"
		end

	generic_derivations_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"generic_derivations_element"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"____class_name"
		end

	index_filename: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"index_filename"
		end

	unary_operators_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"unary_operators_element"
		end

	argument_type_full_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"argument_type_full_name_element"
		end

	frozen ec_illegal_36_ec_illegal_36_update_index (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$update_index"
		end

	make_cache_handler is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"make_cache_handler"
		end

	frozen ec_illegal_36_ec_illegal_36_prepare_type_storage (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER; an_assembly_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER, ASSEMBLY_DESCRIPTOR): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$prepare_type_storage"
		end

	a_set_eiffel_assembly (eiffel_assembly2: EIFFEL_ASSEMBLY) is
		external
			"IL signature (EIFFEL_ASSEMBLY): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"_set_eiffel_assembly"
		end

	access_violation_error: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"access_violation_error"
		end

	last_removal_successful: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"last_removal_successful"
		end

	precondition_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"precondition_element"
		end

	remove_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"remove_assembly"
		end

	dash: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"dash"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"default_pointer"
		end

	binary_operators_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"binary_operators_element"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"default_rescue"
		end

	inherit_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"inherit_element"
		end

	header_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"header_element"
		end

	constraint_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"constraint_element"
		end

	frozen ec_illegal_36_ec_illegal_36_make_cache_handler (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$make_cache_handler"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_types_from_xml (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER; xml_filename: STRING): LINKED_LIST_ANY is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER, STRING): LINKED_LIST_ANY use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$assembly_types_from_xml"
		end

	postcondition_tag_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"postcondition_tag_element"
		end

	frozen ec_illegal_36_ec_illegal_36_has_read_lock_code (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER): INTEGER is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER): System.Int32 use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$has_read_lock_code"
		end

	generic_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"generic_element"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"tagged_out"
		end

	bit_or_infix_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"bit_or_infix_element"
		end

	body_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"body_element"
		end

	modified_feature_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"modified_feature_element"
		end

	a_set_assembly_folder_path (assembly_folder_path2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"_set_assembly_folder_path"
		end

	namespace_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"namespace_element"
		end

	from_support_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"from_support_string"
		end

	update_index is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"update_index"
		end

	enum_literal_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"enum_literal_element"
		end

	invariant_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"invariant_element"
		end

	is_literal_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"is_literal_element"
		end

	generic_derivation_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"generic_derivation_element"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"default"
		end

	postconditions_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"postconditions_element"
		end

	invariant_text_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"invariant_text_element"
		end

	derivation_types_count_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"derivation_types_count_element"
		end

	assembly_types_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"assembly_types_element"
		end

	preconditions_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"preconditions_element"
		end

	a_set_last_write_successful (last_write_successful2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"_set_last_write_successful"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"deep_copy"
		end

	prefix_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"prefix_element"
		end

	false_string: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"false_string"
		end

	error_caption: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"error_caption"
		end

	redefine_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"redefine_element"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"internal_clone"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"do_nothing"
		end

	alias_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"alias_element"
		end

	abstract_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"abstract_element"
		end

	last_write_successful: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"last_write_successful"
		end

	from_system_string (string: SYSTEM_STRING): STRING is
		external
			"IL signature (System.String): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"from_system_string"
		end

	method_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"method_element"
		end

	postcondition_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"postcondition_element"
		end

	initialization_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"initialization_element"
		end

	access_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"access_element"
		end

	invariant_tag_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"invariant_tag_element"
		end

	generic_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"generic_type_element"
		end

	class_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"class_element"
		end

	enum_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"enum_type_element"
		end

	modified_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"modified_element"
		end

	specials_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"specials_element"
		end

	assembly_public_key_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"assembly_public_key_element"
		end

	create_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"create_element"
		end

	generic_type_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"generic_type_eiffel_name_element"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"ToString"
		end

	assembly_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"assembly_name_element"
		end

	prepare_assembly_storage is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"prepare_assembly_storage"
		end

	parent_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"parent_name_element"
		end

	frozen ec_illegal_36_ec_illegal_36_error_caption (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER): STRING is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$error_caption"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"Equals"
		end

	write_lock_creation_failed_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"write_lock_creation_failed_code"
		end

	empty_string: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"empty_string"
		end

	return_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"return_type_element"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"out"
		end

	generic_type_external_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"generic_type_external_name_element"
		end

	export_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"export_element"
		end

	generate_assembly_xml_file is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"generate_assembly_xml_file"
		end

	constraints_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"constraints_element"
		end

	a_set_assembly_descriptor (assembly_descriptor2: ASSEMBLY_DESCRIPTOR) is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"_set_assembly_descriptor"
		end

	a_set_error_messages (error_messages2: EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES) is
		external
			"IL signature (EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"_set_error_messages"
		end

	feature_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"feature_eiffel_name_element"
		end

	footer_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"footer_element"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"deep_equal"
		end

	error_messages: EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES is
		external
			"IL signature (): EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"error_messages"
		end

	frozen ec_illegal_36_ec_illegal_36_is_valid_directory_path (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER; a_folder_name: STRING): BOOLEAN is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER, STRING): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$is_valid_directory_path"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"standard_copy"
		end

	xml_extension: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"xml_extension"
		end

	rename_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"rename_element"
		end

	argument_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"argument_eiffel_name_element"
		end

	support: CODE_GENERATION_SUPPORT is
		external
			"IL signature (): CODE_GENERATION_SUPPORT use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"support"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"deep_clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"standard_equal"
		end

	store_assembly (an_eiffel_assembly: EIFFEL_ASSEMBLY): TYPE_STORER is
		external
			"IL signature (EIFFEL_ASSEMBLY): TYPE_STORER use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"store_assembly"
		end

	a_set_last_error (last_error2: ERROR_INFO) is
		external
			"IL signature (ERROR_INFO): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"_set_last_error"
		end

	frozen_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"frozen_element"
		end

	frozen ec_illegal_36_ec_illegal_36_is_valid_filename (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER; a_filename: STRING): BOOLEAN is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER, STRING): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$is_valid_filename"
		end

	argument_external_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"argument_external_name_element"
		end

	assembly_type_filename_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"assembly_type_filename_element"
		end

	assembly_filename_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"assembly_filename_element"
		end

	update_assembly_description (an_eiffel_assembly: EIFFEL_ASSEMBLY; new_path: STRING) is
		external
			"IL signature (EIFFEL_ASSEMBLY, STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"update_assembly_description"
		end

	last_error: ERROR_INFO is
		external
			"IL signature (): ERROR_INFO use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"last_error"
		end

	from_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"from_notifier_string"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"equal"
		end

	undefine_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"undefine_element"
		end

	feature_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"feature_element"
		end

	comments_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"comments_element"
		end

	class_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"class_eiffel_name_element"
		end

	create_none_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"create_none_element"
		end

	dtd_extension: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"dtd_extension"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"generating_type"
		end

	assembly_descriptor: ASSEMBLY_DESCRIPTOR is
		external
			"IL signature (): ASSEMBLY_DESCRIPTOR use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"assembly_descriptor"
		end

	frozen ec_illegal_36_ec_illegal_36_update_assembly_description (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER; an_eiffel_assembly: EIFFEL_ASSEMBLY; new_path: STRING) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER, EIFFEL_ASSEMBLY, STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$update_assembly_description"
		end

	eiffel_assembly: EIFFEL_ASSEMBLY is
		external
			"IL signature (): EIFFEL_ASSEMBLY use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"eiffel_assembly"
		end

	emitter_version_number_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"emitter_version_number_element"
		end

	infix_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"infix_element"
		end

	eiffel_cluster_path_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"eiffel_cluster_path_element"
		end

	is_valid_filename (a_filename: STRING): BOOLEAN is
		external
			"IL signature (STRING): System.Boolean use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"is_valid_filename"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"print"
		end

	element_change_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"element_change_element"
		end

	commit is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"commit"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"copy"
		end

	frozen ec_illegal_36_ec_illegal_36_commit (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$commit"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_assembly (current_: EIFFEL_ASSEMBLY_CACHE_HANDLER; a_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_CACHE_HANDLER, ASSEMBLY_DESCRIPTOR): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"$$remove_assembly"
		end

	prepare_type_storage (an_assembly_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"prepare_type_storage"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"internal_copy"
		end

	argument_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"argument_element"
		end

	type_storer_from_class (an_eiffel_class: EIFFEL_CLASS): TYPE_STORER is
		external
			"IL signature (EIFFEL_CLASS): TYPE_STORER use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"type_storer_from_class"
		end

	comma: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"comma"
		end

	deferred_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"deferred_element"
		end

	arguments_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"arguments_element"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"generator"
		end

	creation_routine_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"creation_routine_element"
		end

	argument_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"argument_type_element"
		end

	assembly_element: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"assembly_element"
		end

	dtd_assembly_filename: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"dtd_assembly_filename"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_EIFFEL_ASSEMBLY_CACHE_HANDLER
