indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.TYPE_STORER"

external class
	IMPLEMENTATION_TYPE_STORER

inherit
	TYPE_STORER
	EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT
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
			"IL creator use Implementation.TYPE_STORER"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_last_error: ERROR_INFO is
		external
			"IL field signature :ERROR_INFO use Implementation.TYPE_STORER"
		alias
			"$$last_error"
		end

	frozen ec_illegal_36_ec_illegal_36_committed: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.TYPE_STORER"
		alias
			"$$committed"
		end

	frozen ec_illegal_36_ec_illegal_36_types: LINKED_LIST_ANY is
		external
			"IL field signature :LINKED_LIST_ANY use Implementation.TYPE_STORER"
		alias
			"$$types"
		end

	frozen ec_illegal_36_ec_illegal_36_parents: HASH_TABLE_ANY_ANY is
		external
			"IL field signature :HASH_TABLE_ANY_ANY use Implementation.TYPE_STORER"
		alias
			"$$parents"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_class: EIFFEL_CLASS is
		external
			"IL field signature :EIFFEL_CLASS use Implementation.TYPE_STORER"
		alias
			"$$eiffel_class"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_folder_name: STRING is
		external
			"IL field signature :STRING use Implementation.TYPE_STORER"
		alias
			"$$assembly_folder_name"
		end

	frozen ec_illegal_36_ec_illegal_36_text_writer: SYSTEM_XML_XML_TEXT_WRITER is
		external
			"IL field signature :System.Xml.XmlTextWriter use Implementation.TYPE_STORER"
		alias
			"$$text_writer"
		end

	frozen ec_illegal_36_ec_illegal_36_error_messages: TYPE_STORER_ERROR_MESSAGES is
		external
			"IL field signature :TYPE_STORER_ERROR_MESSAGES use Implementation.TYPE_STORER"
		alias
			"$$error_messages"
		end

feature -- Basic Operations

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TYPE_STORER"
		alias
			"conforms_to"
		end

	assembly_version_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"assembly_version_element"
		end

	generate_xml_feature_element (a_feature: EIFFEL_FEATURE) is
		external
			"IL signature (EIFFEL_FEATURE): System.Void use Implementation.TYPE_STORER"
		alias
			"generate_xml_feature_element"
		end

	space: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"space"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_xml_elements_from_feature_arguments (current_: TYPE_STORER; arguments: LINKED_LIST_ANY) is
		external
			"IL static signature (TYPE_STORER, LINKED_LIST_ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"$$generate_xml_elements_from_feature_arguments"
		end

	precondition_tag_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"precondition_tag_element"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_xml_class_header (current_: TYPE_STORER) is
		external
			"IL static signature (TYPE_STORER): System.Void use Implementation.TYPE_STORER"
		alias
			"$$generate_xml_class_header"
		end

	a_set_eiffel_class (eiffel_class2: EIFFEL_CLASS) is
		external
			"IL signature (EIFFEL_CLASS): System.Void use Implementation.TYPE_STORER"
		alias
			"_set_eiffel_class"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_xml_features_element (current_: TYPE_STORER; features: LINKED_LIST_ANY) is
		external
			"IL static signature (TYPE_STORER, LINKED_LIST_ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"$$generate_xml_features_element"
		end

	to_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.TYPE_STORER"
		alias
			"to_component_string"
		end

	frozen ec_illegal_36_ec_illegal_36_support (current_: TYPE_STORER): CODE_GENERATION_SUPPORT is
		external
			"IL static signature (TYPE_STORER): CODE_GENERATION_SUPPORT use Implementation.TYPE_STORER"
		alias
			"$$support"
		end

	generate_xml_element_from_inheritance_clauses (xml_element: STRING; a_list: LINKED_LIST_ANY) is
		external
			"IL signature (STRING, LINKED_LIST_ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"generate_xml_element_from_inheritance_clauses"
		end

	select_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"select_element"
		end

	literal_value_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"literal_value_element"
		end

	feature_external_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"feature_external_name_element"
		end

	assembly_description_filename: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"assembly_description_filename"
		end

	expanded_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"expanded_element"
		end

	parent_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"parent_element"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_xml_alias_element (current_: TYPE_STORER) is
		external
			"IL static signature (TYPE_STORER): System.Void use Implementation.TYPE_STORER"
		alias
			"$$generate_xml_alias_element"
		end

	frozen_feature_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"frozen_feature_element"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TYPE_STORER"
		alias
			"is_equal"
		end

	precondition_text_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"precondition_text_element"
		end

	implementation_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"implementation_element"
		end

	invariants_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"invariants_element"
		end

	dtd_type_filename: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"dtd_type_filename"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TYPE_STORER"
		alias
			"same_type"
		end

	from_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.TYPE_STORER"
		alias
			"from_component_string"
		end

	simple_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"simple_name_element"
		end

	field_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"field_element"
		end

	generate_xml_elements_from_assertions (assertions: LINKED_LIST_ANY; assertion_type: STRING) is
		external
			"IL signature (LINKED_LIST_ANY, STRING): System.Void use Implementation.TYPE_STORER"
		alias
			"generate_xml_elements_from_assertions"
		end

	new_slot_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"new_slot_element"
		end

	generate_xml_features_element (features: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"generate_xml_features_element"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.TYPE_STORER"
		alias
			"default_create"
		end

	basic_operations_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"basic_operations_element"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.TYPE_STORER"
		alias
			"io"
		end

	return_type_full_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"return_type_full_name_element"
		end

	return_type_generic_parameter_index_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"return_type_generic_parameter_index_element"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TYPE_STORER"
		alias
			"standard_is_equal"
		end

	generic_parameter_index_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"generic_parameter_index_element"
		end

	generate_xml_class_body is
		external
			"IL signature (): System.Void use Implementation.TYPE_STORER"
		alias
			"generate_xml_class_body"
		end

	static_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"static_element"
		end

	dot_string: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"dot_string"
		end

	assembly_culture_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"assembly_culture_element"
		end

	string_from_list (a_list: LINKED_LIST_ANY): STRING is
		external
			"IL signature (LINKED_LIST_ANY): STRING use Implementation.TYPE_STORER"
		alias
			"string_from_list"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_generic_derivations (current_: TYPE_STORER) is
		external
			"IL static signature (TYPE_STORER): System.Void use Implementation.TYPE_STORER"
		alias
			"$$generate_generic_derivations"
		end

	assemblies_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"assemblies_element"
		end

	true_string: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"true_string"
		end

	frozen ec_illegal_36_ec_illegal_36_string_from_list (current_: TYPE_STORER; a_list: LINKED_LIST_ANY): STRING is
		external
			"IL static signature (TYPE_STORER, LINKED_LIST_ANY): STRING use Implementation.TYPE_STORER"
		alias
			"$$string_from_list"
		end

	to_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.TYPE_STORER"
		alias
			"to_notifier_string"
		end

	postcondition_text_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"postcondition_text_element"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.TYPE_STORER"
		alias
			"operating_environment"
		end

	generic_derivations_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"generic_derivations_element"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.TYPE_STORER"
		alias
			"____class_name"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_xml_inherit_element (current_: TYPE_STORER) is
		external
			"IL static signature (TYPE_STORER): System.Void use Implementation.TYPE_STORER"
		alias
			"$$generate_xml_inherit_element"
		end

	index_filename: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"index_filename"
		end

	unary_operators_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"unary_operators_element"
		end

	argument_type_full_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"argument_type_full_name_element"
		end

	a_set_committed (committed2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.TYPE_STORER"
		alias
			"_set_committed"
		end

	committed: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.TYPE_STORER"
		alias
			"committed"
		end

	generate_xml_alias_element is
		external
			"IL signature (): System.Void use Implementation.TYPE_STORER"
		alias
			"generate_xml_alias_element"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_exists (current_: TYPE_STORER; a_filename: STRING): BOOLEAN is
		external
			"IL static signature (TYPE_STORER, STRING): System.Boolean use Implementation.TYPE_STORER"
		alias
			"$$exists"
		end

	precondition_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"precondition_element"
		end

	dash: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"dash"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.TYPE_STORER"
		alias
			"default_pointer"
		end

	binary_operators_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"binary_operators_element"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.TYPE_STORER"
		alias
			"default_rescue"
		end

	inherit_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"inherit_element"
		end

	header_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"header_element"
		end

	constraint_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"constraint_element"
		end

	frozen ec_illegal_36_ec_illegal_36_string_from_inheritance_clauses (current_: TYPE_STORER; a_list: LINKED_LIST_ANY): STRING is
		external
			"IL static signature (TYPE_STORER, LINKED_LIST_ANY): STRING use Implementation.TYPE_STORER"
		alias
			"$$string_from_inheritance_clauses"
		end

	postcondition_tag_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"postcondition_tag_element"
		end

	generic_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"generic_element"
		end

	generate_xml_elements_from_feature_arguments (arguments: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"generate_xml_elements_from_feature_arguments"
		end

	bit_or_infix_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"bit_or_infix_element"
		end

	body_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"body_element"
		end

	modified_feature_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"modified_feature_element"
		end

	namespace_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"namespace_element"
		end

	a_set_assembly_folder_name (assembly_folder_name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.TYPE_STORER"
		alias
			"_set_assembly_folder_name"
		end

	from_support_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.TYPE_STORER"
		alias
			"from_support_string"
		end

	eiffel_class: EIFFEL_CLASS is
		external
			"IL signature (): EIFFEL_CLASS use Implementation.TYPE_STORER"
		alias
			"eiffel_class"
		end

	generate_generic_derivations is
		external
			"IL signature (): System.Void use Implementation.TYPE_STORER"
		alias
			"generate_generic_derivations"
		end

	generate_xml_element_from_list (xml_element: STRING; a_list: LINKED_LIST_ANY) is
		external
			"IL signature (STRING, LINKED_LIST_ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"generate_xml_element_from_list"
		end

	enum_literal_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"enum_literal_element"
		end

	invariant_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"invariant_element"
		end

	is_literal_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"is_literal_element"
		end

	generic_derivation_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"generic_derivation_element"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.TYPE_STORER"
		alias
			"default"
		end

	postconditions_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"postconditions_element"
		end

	invariant_text_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"invariant_text_element"
		end

	derivation_types_count_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"derivation_types_count_element"
		end

	assembly_types_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"assembly_types_element"
		end

	preconditions_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"preconditions_element"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"deep_copy"
		end

	prefix_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"prefix_element"
		end

	frozen ec_illegal_36_ec_illegal_36_add_type (current_: TYPE_STORER; an_eiffel_class: EIFFEL_CLASS; overwrite: BOOLEAN) is
		external
			"IL static signature (TYPE_STORER, EIFFEL_CLASS, System.Boolean): System.Void use Implementation.TYPE_STORER"
		alias
			"$$add_type"
		end

	false_string: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"false_string"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_xml_elements_from_assertions (current_: TYPE_STORER; assertions: LINKED_LIST_ANY; assertion_type: STRING) is
		external
			"IL static signature (TYPE_STORER, LINKED_LIST_ANY, STRING): System.Void use Implementation.TYPE_STORER"
		alias
			"$$generate_xml_elements_from_assertions"
		end

	generate_xml_inherit_element is
		external
			"IL signature (): System.Void use Implementation.TYPE_STORER"
		alias
			"generate_xml_inherit_element"
		end

	redefine_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"redefine_element"
		end

	a_set_text_writer (text_writer2: SYSTEM_XML_XML_TEXT_WRITER) is
		external
			"IL signature (System.Xml.XmlTextWriter): System.Void use Implementation.TYPE_STORER"
		alias
			"_set_text_writer"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.TYPE_STORER"
		alias
			"internal_clone"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.TYPE_STORER"
		alias
			"do_nothing"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.TYPE_STORER"
		alias
			"GetHashCode"
		end

	alias_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"alias_element"
		end

	abstract_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"abstract_element"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TYPE_STORER"
		alias
			"clone"
		end

	from_system_string (string: SYSTEM_STRING): STRING is
		external
			"IL signature (System.String): STRING use Implementation.TYPE_STORER"
		alias
			"from_system_string"
		end

	method_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"method_element"
		end

	postcondition_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"postcondition_element"
		end

	initialization_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"initialization_element"
		end

	access_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"access_element"
		end

	invariant_tag_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"invariant_tag_element"
		end

	generic_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"generic_type_element"
		end

	class_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"class_element"
		end

	enum_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"enum_type_element"
		end

	modified_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"modified_element"
		end

	specials_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"specials_element"
		end

	assembly_public_key_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"assembly_public_key_element"
		end

	create_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"create_element"
		end

	generic_type_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"generic_type_eiffel_name_element"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.TYPE_STORER"
		alias
			"ToString"
		end

	assembly_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"assembly_name_element"
		end

	make_type_storer (a_folder_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.TYPE_STORER"
		alias
			"make_type_storer"
		end

	parent_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"parent_name_element"
		end

	a_set_parents (parents2: HASH_TABLE_ANY_ANY) is
		external
			"IL signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"_set_parents"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.TYPE_STORER"
		alias
			"Equals"
		end

	empty_string: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"empty_string"
		end

	return_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"return_type_element"
		end

	a_set_types (types2: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"_set_types"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"out"
		end

	add_type (an_eiffel_class: EIFFEL_CLASS; overwrite: BOOLEAN) is
		external
			"IL signature (EIFFEL_CLASS, System.Boolean): System.Void use Implementation.TYPE_STORER"
		alias
			"add_type"
		end

	generic_type_external_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"generic_type_external_name_element"
		end

	export_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"export_element"
		end

	text_writer: SYSTEM_XML_XML_TEXT_WRITER is
		external
			"IL signature (): System.Xml.XmlTextWriter use Implementation.TYPE_STORER"
		alias
			"text_writer"
		end

	constraints_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"constraints_element"
		end

	exists (a_filename: STRING): BOOLEAN is
		external
			"IL signature (STRING): System.Boolean use Implementation.TYPE_STORER"
		alias
			"exists"
		end

	a_set_error_messages (error_messages2: TYPE_STORER_ERROR_MESSAGES) is
		external
			"IL signature (TYPE_STORER_ERROR_MESSAGES): System.Void use Implementation.TYPE_STORER"
		alias
			"_set_error_messages"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_xml_class_body (current_: TYPE_STORER) is
		external
			"IL static signature (TYPE_STORER): System.Void use Implementation.TYPE_STORER"
		alias
			"$$generate_xml_class_body"
		end

	frozen ec_illegal_36_ec_illegal_36_update_assembly_description (current_: TYPE_STORER) is
		external
			"IL static signature (TYPE_STORER): System.Void use Implementation.TYPE_STORER"
		alias
			"$$update_assembly_description"
		end

	feature_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"feature_eiffel_name_element"
		end

	footer_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"footer_element"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TYPE_STORER"
		alias
			"deep_equal"
		end

	assembly_folder_name: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"assembly_folder_name"
		end

	error_messages: TYPE_STORER_ERROR_MESSAGES is
		external
			"IL signature (): TYPE_STORER_ERROR_MESSAGES use Implementation.TYPE_STORER"
		alias
			"error_messages"
		end

	frozen ec_illegal_36_ec_illegal_36_is_valid_directory_path (current_: TYPE_STORER; a_folder_name: STRING): BOOLEAN is
		external
			"IL static signature (TYPE_STORER, STRING): System.Boolean use Implementation.TYPE_STORER"
		alias
			"$$is_valid_directory_path"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"standard_copy"
		end

	xml_extension: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"xml_extension"
		end

	rename_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"rename_element"
		end

	argument_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"argument_eiffel_name_element"
		end

	support: CODE_GENERATION_SUPPORT is
		external
			"IL signature (): CODE_GENERATION_SUPPORT use Implementation.TYPE_STORER"
		alias
			"support"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TYPE_STORER"
		alias
			"deep_clone"
		end

	types: LINKED_LIST_ANY is
		external
			"IL signature (): LINKED_LIST_ANY use Implementation.TYPE_STORER"
		alias
			"types"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TYPE_STORER"
		alias
			"standard_equal"
		end

	a_set_last_error (last_error2: ERROR_INFO) is
		external
			"IL signature (ERROR_INFO): System.Void use Implementation.TYPE_STORER"
		alias
			"_set_last_error"
		end

	frozen_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"frozen_element"
		end

	assembly_type_filename_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"assembly_type_filename_element"
		end

	assembly_filename_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"assembly_filename_element"
		end

	update_assembly_description is
		external
			"IL signature (): System.Void use Implementation.TYPE_STORER"
		alias
			"update_assembly_description"
		end

	last_error: ERROR_INFO is
		external
			"IL signature (): ERROR_INFO use Implementation.TYPE_STORER"
		alias
			"last_error"
		end

	from_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.TYPE_STORER"
		alias
			"from_notifier_string"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TYPE_STORER"
		alias
			"equal"
		end

	undefine_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"undefine_element"
		end

	feature_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"feature_element"
		end

	comments_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"comments_element"
		end

	is_valid_directory_path (a_folder_name: STRING): BOOLEAN is
		external
			"IL signature (STRING): System.Boolean use Implementation.TYPE_STORER"
		alias
			"is_valid_directory_path"
		end

	class_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"class_eiffel_name_element"
		end

	create_none_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"create_none_element"
		end

	dtd_extension: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"dtd_extension"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_xml_element_from_inheritance_clauses (current_: TYPE_STORER; xml_element: STRING; a_list: LINKED_LIST_ANY) is
		external
			"IL static signature (TYPE_STORER, STRING, LINKED_LIST_ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"$$generate_xml_element_from_inheritance_clauses"
		end

	argument_external_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"argument_external_name_element"
		end

	to_support_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.TYPE_STORER"
		alias
			"to_support_string"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_xml_feature_element (current_: TYPE_STORER; a_feature: EIFFEL_FEATURE) is
		external
			"IL static signature (TYPE_STORER, EIFFEL_FEATURE): System.Void use Implementation.TYPE_STORER"
		alias
			"$$generate_xml_feature_element"
		end

	string_from_inheritance_clauses (a_list: LINKED_LIST_ANY): STRING is
		external
			"IL signature (LINKED_LIST_ANY): STRING use Implementation.TYPE_STORER"
		alias
			"string_from_inheritance_clauses"
		end

	emitter_version_number_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"emitter_version_number_element"
		end

	infix_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"infix_element"
		end

	parents: HASH_TABLE_ANY_ANY is
		external
			"IL signature (): HASH_TABLE_ANY_ANY use Implementation.TYPE_STORER"
		alias
			"parents"
		end

	eiffel_cluster_path_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"eiffel_cluster_path_element"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TYPE_STORER"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"print"
		end

	generate_xml_class_footer (invariants: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"generate_xml_class_footer"
		end

	element_change_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"element_change_element"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_description_filename (current_: TYPE_STORER): STRING is
		external
			"IL static signature (TYPE_STORER): STRING use Implementation.TYPE_STORER"
		alias
			"$$assembly_description_filename"
		end

	commit is
		external
			"IL signature (): System.Void use Implementation.TYPE_STORER"
		alias
			"commit"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"copy"
		end

	frozen ec_illegal_36_ec_illegal_36_make_type_storer (current_: TYPE_STORER; a_folder_name: STRING) is
		external
			"IL static signature (TYPE_STORER, STRING): System.Void use Implementation.TYPE_STORER"
		alias
			"$$make_type_storer"
		end

	frozen ec_illegal_36_ec_illegal_36_commit (current_: TYPE_STORER) is
		external
			"IL static signature (TYPE_STORER): System.Void use Implementation.TYPE_STORER"
		alias
			"$$commit"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"internal_copy"
		end

	argument_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"argument_element"
		end

	generate_xml_class_header is
		external
			"IL signature (): System.Void use Implementation.TYPE_STORER"
		alias
			"generate_xml_class_header"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_xml_element_from_list (current_: TYPE_STORER; xml_element: STRING; a_list: LINKED_LIST_ANY) is
		external
			"IL static signature (TYPE_STORER, STRING, LINKED_LIST_ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"$$generate_xml_element_from_list"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_xml_class_footer (current_: TYPE_STORER; invariants: LINKED_LIST_ANY) is
		external
			"IL static signature (TYPE_STORER, LINKED_LIST_ANY): System.Void use Implementation.TYPE_STORER"
		alias
			"$$generate_xml_class_footer"
		end

	comma: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"comma"
		end

	deferred_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"deferred_element"
		end

	arguments_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"arguments_element"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"generator"
		end

	creation_routine_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"creation_routine_element"
		end

	argument_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"argument_type_element"
		end

	assembly_element: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"assembly_element"
		end

	dtd_assembly_filename: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER"
		alias
			"dtd_assembly_filename"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.TYPE_STORER"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_TYPE_STORER
