indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.XML_CODE_GENERATOR"

external class
	IMPLEMENTATION_XML_CODE_GENERATOR

inherit
	XML_CODE_GENERATOR
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	XML_ELEMENTS
	CODE_GENERATOR_SUPPORT
	DICTIONARY

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.XML_CODE_GENERATOR"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_cache_handler: EIFFEL_ASSEMBLY_CACHE_HANDLER is
		external
			"IL field signature :EIFFEL_ASSEMBLY_CACHE_HANDLER use Implementation.XML_CODE_GENERATOR"
		alias
			"$$cache_handler"
		end

	frozen ec_illegal_36_ec_illegal_36_type_storer: TYPE_STORER is
		external
			"IL field signature :TYPE_STORER use Implementation.XML_CODE_GENERATOR"
		alias
			"$$type_storer"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.XML_CODE_GENERATOR"
		alias
			"operating_environment"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.XML_CODE_GENERATOR"
		alias
			"is_equal"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.XML_CODE_GENERATOR"
		alias
			"____class_name"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"tagged_out"
		end

	method_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"method_element"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"copy"
		end

	postcondition_text_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"postcondition_text_element"
		end

	a_set_cache_handler (cache_handler2: EIFFEL_ASSEMBLY_CACHE_HANDLER) is
		external
			"IL signature (EIFFEL_ASSEMBLY_CACHE_HANDLER): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"_set_cache_handler"
		end

	comments_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"comments_element"
		end

	frozen_feature_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"frozen_feature_element"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.XML_CODE_GENERATOR"
		alias
			"standard_clone"
		end

	assembly_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"assembly_name_element"
		end

	assembly_version_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"assembly_version_element"
		end

	a_set_type_storer (type_storer2: TYPE_STORER) is
		external
			"IL signature (TYPE_STORER): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"_set_type_storer"
		end

	index_filename: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"index_filename"
		end

	assembly_public_key_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"assembly_public_key_element"
		end

	from_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"from_component_string"
		end

	to_support_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"to_support_string"
		end

	prefix_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"prefix_element"
		end

	create_none_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"create_none_element"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"generator"
		end

	bit_or_infix_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"bit_or_infix_element"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.XML_CODE_GENERATOR"
		alias
			"deep_clone"
		end

	simple_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"simple_name_element"
		end

	assembly_culture_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"assembly_culture_element"
		end

	argument_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"argument_element"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"generating_type"
		end

	argument_external_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"argument_external_name_element"
		end

	arguments_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"arguments_element"
		end

	precondition_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"precondition_element"
		end

	modified_feature_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"modified_feature_element"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"out"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"internal_copy"
		end

	invariants_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"invariants_element"
		end

	creation_routine_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"creation_routine_element"
		end

	eiffel_cluster_path_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"eiffel_cluster_path_element"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.XML_CODE_GENERATOR"
		alias
			"conforms_to"
		end

	true_string: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"true_string"
		end

	argument_type_full_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"argument_type_full_name_element"
		end

	dtd_assembly_filename: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"dtd_assembly_filename"
		end

	return_type_full_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"return_type_full_name_element"
		end

	inherit_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"inherit_element"
		end

	precondition_tag_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"precondition_tag_element"
		end

	generate_type (an_eiffel_class: EIFFEL_CLASS) is
		external
			"IL signature (EIFFEL_CLASS): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"generate_type"
		end

	end_assembly_generation is
		external
			"IL signature (): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"end_assembly_generation"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.XML_CODE_GENERATOR"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_type (current_: XML_CODE_GENERATOR; an_eiffel_class: EIFFEL_CLASS) is
		external
			"IL static signature (XML_CODE_GENERATOR, EIFFEL_CLASS): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"$$generate_type"
		end

	body_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"body_element"
		end

	invariant_text_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"invariant_text_element"
		end

	static_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"static_element"
		end

	postcondition_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"postcondition_element"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.XML_CODE_GENERATOR"
		alias
			"io"
		end

	alias_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"alias_element"
		end

	enum_literal_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"enum_literal_element"
		end

	to_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"to_notifier_string"
		end

	assembly_filename_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"assembly_filename_element"
		end

	frozen ec_illegal_36_ec_illegal_36_end_assembly_generation (current_: XML_CODE_GENERATOR) is
		external
			"IL static signature (XML_CODE_GENERATOR): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"$$end_assembly_generation"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.XML_CODE_GENERATOR"
		alias
			"ToString"
		end

	feature_external_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"feature_external_name_element"
		end

	create_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"create_element"
		end

	feature_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"feature_element"
		end

	postconditions_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"postconditions_element"
		end

	generic_type_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"generic_type_eiffel_name_element"
		end

	assembly_type_filename_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"assembly_type_filename_element"
		end

	namespace_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"namespace_element"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.XML_CODE_GENERATOR"
		alias
			"default"
		end

	empty_string: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"empty_string"
		end

	argument_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"argument_type_element"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.XML_CODE_GENERATOR"
		alias
			"same_type"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"do_nothing"
		end

	deferred_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"deferred_element"
		end

	access_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"access_element"
		end

	assembly_types_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"assembly_types_element"
		end

	implementation_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"implementation_element"
		end

	postcondition_tag_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"postcondition_tag_element"
		end

	class_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"class_element"
		end

	false_string: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"false_string"
		end

	constraints_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"constraints_element"
		end

	replace_type (an_eiffel_class: EIFFEL_CLASS) is
		external
			"IL signature (EIFFEL_CLASS): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"replace_type"
		end

	feature_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"feature_eiffel_name_element"
		end

	return_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"return_type_element"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"default_create"
		end

	argument_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"argument_eiffel_name_element"
		end

	frozen ec_illegal_36_ec_illegal_36_make_xml_code_generator (current_: XML_CODE_GENERATOR) is
		external
			"IL static signature (XML_CODE_GENERATOR): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"$$make_xml_code_generator"
		end

	precondition_text_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"precondition_text_element"
		end

	assemblies_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"assemblies_element"
		end

	from_handler_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"from_handler_string"
		end

	rename_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"rename_element"
		end

	from_system_string (string: SYSTEM_STRING): STRING is
		external
			"IL signature (System.String): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"from_system_string"
		end

	abstract_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"abstract_element"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"standard_copy"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.XML_CODE_GENERATOR"
		alias
			"standard_is_equal"
		end

	is_literal_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"is_literal_element"
		end

	parent_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"parent_element"
		end

	basic_operations_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"basic_operations_element"
		end

	frozen ec_illegal_36_ec_illegal_36_start_assembly_generation (current_: XML_CODE_GENERATOR; an_eiffel_assembly: EIFFEL_ASSEMBLY) is
		external
			"IL static signature (XML_CODE_GENERATOR, EIFFEL_ASSEMBLY): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"$$start_assembly_generation"
		end

	space: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"space"
		end

	class_eiffel_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"class_eiffel_name_element"
		end

	field_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"field_element"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"deep_copy"
		end

	emitter_version_number_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"emitter_version_number_element"
		end

	return_type_generic_parameter_index_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"return_type_generic_parameter_index_element"
		end

	new_slot_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"new_slot_element"
		end

	from_support_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"from_support_string"
		end

	element_change_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"element_change_element"
		end

	derivation_types_count_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"derivation_types_count_element"
		end

	preconditions_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"preconditions_element"
		end

	parent_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"parent_name_element"
		end

	generic_derivation_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"generic_derivation_element"
		end

	infix_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"infix_element"
		end

	make_xml_code_generator is
		external
			"IL signature (): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"make_xml_code_generator"
		end

	cache_handler: EIFFEL_ASSEMBLY_CACHE_HANDLER is
		external
			"IL signature (): EIFFEL_ASSEMBLY_CACHE_HANDLER use Implementation.XML_CODE_GENERATOR"
		alias
			"cache_handler"
		end

	to_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"to_component_string"
		end

	literal_value_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"literal_value_element"
		end

	frozen_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"frozen_element"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.XML_CODE_GENERATOR"
		alias
			"equal"
		end

	redefine_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"redefine_element"
		end

	generic_parameter_index_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"generic_parameter_index_element"
		end

	footer_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"footer_element"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.XML_CODE_GENERATOR"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.XML_CODE_GENERATOR"
		alias
			"standard_equal"
		end

	select_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"select_element"
		end

	enum_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"enum_type_element"
		end

	to_handler_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"to_handler_string"
		end

	binary_operators_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"binary_operators_element"
		end

	specials_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"specials_element"
		end

	generic_derivations_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"generic_derivations_element"
		end

	dot_string: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"dot_string"
		end

	frozen ec_illegal_36_ec_illegal_36_replace_type (current_: XML_CODE_GENERATOR; an_eiffel_class: EIFFEL_CLASS) is
		external
			"IL static signature (XML_CODE_GENERATOR, EIFFEL_CLASS): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"$$replace_type"
		end

	generic_type_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"generic_type_element"
		end

	modified_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"modified_element"
		end

	invariant_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"invariant_element"
		end

	dtd_extension: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"dtd_extension"
		end

	export_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"export_element"
		end

	invariant_tag_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"invariant_tag_element"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.XML_CODE_GENERATOR"
		alias
			"GetHashCode"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.XML_CODE_GENERATOR"
		alias
			"deep_equal"
		end

	type_storer: TYPE_STORER is
		external
			"IL signature (): TYPE_STORER use Implementation.XML_CODE_GENERATOR"
		alias
			"type_storer"
		end

	xml_extension: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"xml_extension"
		end

	generic_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"generic_element"
		end

	constraint_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"constraint_element"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"default_rescue"
		end

	dash: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"dash"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.XML_CODE_GENERATOR"
		alias
			"internal_clone"
		end

	unary_operators_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"unary_operators_element"
		end

	undefine_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"undefine_element"
		end

	assembly_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"assembly_element"
		end

	comma: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"comma"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.XML_CODE_GENERATOR"
		alias
			"default_pointer"
		end

	start_assembly_generation (an_eiffel_assembly: EIFFEL_ASSEMBLY) is
		external
			"IL signature (EIFFEL_ASSEMBLY): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"start_assembly_generation"
		end

	dtd_type_filename: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"dtd_type_filename"
		end

	from_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"from_notifier_string"
		end

	expanded_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"expanded_element"
		end

	generic_type_external_name_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"generic_type_external_name_element"
		end

	initialization_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"initialization_element"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"print"
		end

	header_element: STRING is
		external
			"IL signature (): STRING use Implementation.XML_CODE_GENERATOR"
		alias
			"header_element"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.XML_CODE_GENERATOR"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_XML_CODE_GENERATOR
