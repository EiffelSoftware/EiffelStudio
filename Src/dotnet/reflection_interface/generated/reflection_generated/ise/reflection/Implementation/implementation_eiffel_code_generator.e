indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.EIFFEL_CODE_GENERATOR"

external class
	IMPLEMENTATION_EIFFEL_CODE_GENERATOR

inherit
	EIFFEL_CODE_GENERATOR
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	CODE_GENERATOR_SUPPORT
	DICTIONARY
	EIFFEL_CODE_GENERATOR_DICTIONARY

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.EIFFEL_CODE_GENERATOR"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_parents: HASH_TABLE_ANY_ANY is
		external
			"IL field signature :HASH_TABLE_ANY_ANY use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$parents"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_class: EIFFEL_CLASS is
		external
			"IL field signature :EIFFEL_CLASS use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$eiffel_class"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_assembly: EIFFEL_ASSEMBLY is
		external
			"IL field signature :EIFFEL_ASSEMBLY use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$eiffel_assembly"
		end

	frozen ec_illegal_36_ec_illegal_36_generated_code: STRING is
		external
			"IL field signature :STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$generated_code"
		end

feature -- Basic Operations

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"conforms_to"
		end

	is_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"is_keyword"
		end

	a_set_eiffel_class (eiffel_class2: EIFFEL_CLASS) is
		external
			"IL signature (EIFFEL_CLASS): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"_set_eiffel_class"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_eiffel_class (current_: EIFFEL_CODE_GENERATOR; an_eiffel_class: EIFFEL_CLASS) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR, EIFFEL_CLASS): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$generate_eiffel_class"
		end

	a_set_generated_code (generated_code2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"_set_generated_code"
		end

	generator_name: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generator_name"
		end

	unary_operators_feature_clause: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"unary_operators_feature_clause"
		end

	frozen ec_illegal_36_ec_illegal_36_bit_or_infix_code (current_: EIFFEL_CODE_GENERATOR): STRING is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$bit_or_infix_code"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_external_clause (current_: EIFFEL_CODE_GENERATOR; a_feature: EIFFEL_FEATURE) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR, EIFFEL_FEATURE): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$generate_external_clause"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"____class_name"
		end

	external_name_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"external_name_keyword"
		end

	prefix_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"prefix_keyword"
		end

	closing_round_bracket: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"closing_round_bracket"
		end

	do_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"do_keyword"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"is_equal"
		end

	generic_types_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generic_types_keyword"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_inheritance_clauses (current_: EIFFEL_CODE_GENERATOR; clauses: LINKED_LIST_ANY) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR, LINKED_LIST_ANY): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$generate_inheritance_clauses"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"standard_equal"
		end

	generate_eiffel_class (an_eiffel_class: EIFFEL_CLASS) is
		external
			"IL signature (EIFFEL_CLASS): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generate_eiffel_class"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"operating_environment"
		end

	dtd_type_filename: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"dtd_type_filename"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"same_type"
		end

	double_class: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"double_class"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"default"
		end

	generate_constraints is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generate_constraints"
		end

	bit_or_infix_code: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"bit_or_infix_code"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"io"
		end

	dashes: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"dashes"
		end

	il: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"il"
		end

	generate_generic_clauses is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generate_generic_clauses"
		end

	deferred_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"deferred_keyword"
		end

	create_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"create_keyword"
		end

	frozen ec_illegal_36_ec_illegal_36_special_classes (current_: EIFFEL_CODE_GENERATOR): HASH_TABLE_ANY_ANY is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR): HASH_TABLE_ANY_ANY use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$special_classes"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"standard_is_equal"
		end

	rename_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"rename_keyword"
		end

	has_any_undefine: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"has_any_undefine"
		end

	dot_string: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"dot_string"
		end

	special_classes: HASH_TABLE_ANY_ANY is
		external
			"IL signature (): HASH_TABLE_ANY_ANY use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"special_classes"
		end

	frozen ec_illegal_36_ec_illegal_36_has_any_redefine (current_: EIFFEL_CODE_GENERATOR): BOOLEAN is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$has_any_redefine"
		end

	frozen ec_illegal_36_ec_illegal_36_feature_signature (current_: EIFFEL_CODE_GENERATOR; a_feature: EIFFEL_FEATURE): STRING is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR, EIFFEL_FEATURE): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$feature_signature"
		end

	frozen ec_illegal_36_ec_illegal_36_has_any_undefine (current_: EIFFEL_CODE_GENERATOR): BOOLEAN is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$has_any_undefine"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"internal_clone"
		end

	make_eiffel_code_generator is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"make_eiffel_code_generator"
		end

	built_in_comment: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"built_in_comment"
		end

	true_string: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"true_string"
		end

	new_line: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"new_line"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_eiffel_class_from_path (current_: EIFFEL_CODE_GENERATOR; an_eiffel_class: EIFFEL_CLASS; a_path: STRING) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR, EIFFEL_CLASS, STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$generate_eiffel_class_from_path"
		end

	frozen ec_illegal_36_ec_illegal_36_make_eiffel_code_generator (current_: EIFFEL_CODE_GENERATOR) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$make_eiffel_code_generator"
		end

	frozen ec_illegal_36_ec_illegal_36_built_in_comment (current_: EIFFEL_CODE_GENERATOR): STRING is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$built_in_comment"
		end

	undefine_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"undefine_keyword"
		end

	make_from_info (an_eiffel_assembly: EIFFEL_ASSEMBLY) is
		external
			"IL signature (EIFFEL_ASSEMBLY): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"make_from_info"
		end

	frozen ec_illegal_36_ec_illegal_36_intern_generate_class_features (current_: EIFFEL_CODE_GENERATOR; a_list: LINKED_LIST_ANY) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR, LINKED_LIST_ANY): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$intern_generate_class_features"
		end

	external_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"external_keyword"
		end

	indexing_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"indexing_keyword"
		end

	index_filename: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"index_filename"
		end

	real_class: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"real_class"
		end

	static: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"static"
		end

	static_field: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"static_field"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_generic_types (current_: EIFFEL_CODE_GENERATOR) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$generate_generic_types"
		end

	a_set_eiffel_assembly (eiffel_assembly2: EIFFEL_ASSEMBLY) is
		external
			"IL signature (EIFFEL_ASSEMBLY): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"_set_eiffel_assembly"
		end

	character_class: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"character_class"
		end

	generate_class_features is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generate_class_features"
		end

	boolean_class: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"boolean_class"
		end

	feature_signature (a_feature: EIFFEL_FEATURE): STRING is
		external
			"IL signature (EIFFEL_FEATURE): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"feature_signature"
		end

	dash: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"dash"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"default_pointer"
		end

	class_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"class_keyword"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"default_rescue"
		end

	generated_code: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generated_code"
		end

	any_class: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"any_class"
		end

	inherit_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"inherit_keyword"
		end

	from_handler_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"from_handler_string"
		end

	generate_inherit_clause is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generate_inherit_clause"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"tagged_out"
		end

	from_support_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"from_support_string"
		end

	field: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"field"
		end

	eiffel_class: EIFFEL_CLASS is
		external
			"IL signature (): EIFFEL_CLASS use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"eiffel_class"
		end

	generate_external_clause (a_feature: EIFFEL_FEATURE) is
		external
			"IL signature (EIFFEL_FEATURE): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generate_external_clause"
		end

	generate_eiffel_feature (a_feature: EIFFEL_FEATURE) is
		external
			"IL signature (EIFFEL_FEATURE): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generate_eiffel_feature"
		end

	expanded_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"expanded_keyword"
		end

	access_feature_clause: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"access_feature_clause"
		end

	to_support_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"to_support_string"
		end

	to_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"to_component_string"
		end

	space: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"space"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_create_clause (current_: EIFFEL_CODE_GENERATOR) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$generate_create_clause"
		end

	generate_feature_assertions (assertions: LINKED_LIST_ANY; keyword: STRING) is
		external
			"IL signature (LINKED_LIST_ANY, STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generate_feature_assertions"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_inherit_clause (current_: EIFFEL_CODE_GENERATOR) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$generate_inherit_clause"
		end

	generate_generic_types is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generate_generic_types"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"deep_copy"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"deep_equal"
		end

	to_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"to_notifier_string"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_eiffel_feature (current_: EIFFEL_CODE_GENERATOR; a_feature: EIFFEL_FEATURE) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR, EIFFEL_FEATURE): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$generate_eiffel_feature"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_constraints (current_: EIFFEL_CODE_GENERATOR) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$generate_constraints"
		end

	bit_or_infix_signature: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"bit_or_infix_signature"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"do_nothing"
		end

	empty_string: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"empty_string"
		end

	select_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"select_keyword"
		end

	initialization_feature_clause: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"initialization_feature_clause"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"clone"
		end

	from_system_string (string: SYSTEM_STRING): STRING is
		external
			"IL signature (System.String): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"from_system_string"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"equal"
		end

	has_any_redefine: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"has_any_redefine"
		end

	constraints_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"constraints_keyword"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"ToString"
		end

	specials_feature_clause: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"specials_feature_clause"
		end

	intern_generate_eiffel_class (a_filename: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"intern_generate_eiffel_class"
		end

	semi_colon: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"semi_colon"
		end

	a_set_parents (parents2: HASH_TABLE_ANY_ANY) is
		external
			"IL signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"_set_parents"
		end

	enum_type_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"enum_type_keyword"
		end

	intern_generate_class_features (a_list: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"intern_generate_class_features"
		end

	frozen_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"frozen_keyword"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"out"
		end

	has_any_rename: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"has_any_rename"
		end

	eiffel_class_extension: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"eiffel_class_extension"
		end

	require_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"require_keyword"
		end

	implementation_feature_clause: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"implementation_feature_clause"
		end

	opening_square_bracket: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"opening_square_bracket"
		end

	integer_8_class: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"integer_8_class"
		end

	alias_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"alias_keyword"
		end

	binary_operators_feature_clause: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"binary_operators_feature_clause"
		end

	signature_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"signature_keyword"
		end

	end_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"end_keyword"
		end

	colon: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"colon"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"standard_copy"
		end

	xml_extension: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"xml_extension"
		end

	generate_eiffel_class_from_path (an_eiffel_class: EIFFEL_CLASS; a_path: STRING) is
		external
			"IL signature (EIFFEL_CLASS, STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generate_eiffel_class_from_path"
		end

	integer_class: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"integer_class"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"deep_clone"
		end

	property_set_prefix: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"property_set_prefix"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"GetHashCode"
		end

	integer_16_class: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"integer_16_class"
		end

	initialization_feature_clause_exported_to_none: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"initialization_feature_clause_exported_to_none"
		end

	frozen ec_illegal_36_ec_illegal_36_intern_generate_eiffel_class (current_: EIFFEL_CODE_GENERATOR; a_filename: STRING) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR, STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$intern_generate_eiffel_class"
		end

	frozen ec_illegal_36_ec_illegal_36_has_any_rename (current_: EIFFEL_CODE_GENERATOR): BOOLEAN is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$has_any_rename"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_info (current_: EIFFEL_CODE_GENERATOR; an_eiffel_assembly: EIFFEL_ASSEMBLY) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR, EIFFEL_ASSEMBLY): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$make_from_info"
		end

	windows_new_line: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"windows_new_line"
		end

	from_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"from_notifier_string"
		end

	false_string: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"false_string"
		end

	basic_operations_feature_clause: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"basic_operations_feature_clause"
		end

	create_none: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"create_none"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_class_features (current_: EIFFEL_CODE_GENERATOR) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$generate_class_features"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_generic_clauses (current_: EIFFEL_CODE_GENERATOR) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$generate_generic_clauses"
		end

	use: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"use"
		end

	inverted_comma: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"inverted_comma"
		end

	creator: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"creator"
		end

	ensure_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"ensure_keyword"
		end

	dtd_extension: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"dtd_extension"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generating_type"
		end

	opening_round_bracket: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"opening_round_bracket"
		end

	to_handler_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"to_handler_string"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"Equals"
		end

	eiffel_assembly: EIFFEL_ASSEMBLY is
		external
			"IL signature (): EIFFEL_ASSEMBLY use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"eiffel_assembly"
		end

	operator: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"operator"
		end

	redefine_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"redefine_keyword"
		end

	element_change_feature_clause: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"element_change_feature_clause"
		end

	parents: HASH_TABLE_ANY_ANY is
		external
			"IL signature (): HASH_TABLE_ANY_ANY use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"parents"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"print"
		end

	enum_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"enum_keyword"
		end

	generator_indexing_clause: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generator_indexing_clause"
		end

	tab: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"tab"
		end

	is_special_class: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"is_special_class"
		end

	generate_inheritance_clauses (clauses: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generate_inheritance_clauses"
		end

	generate_create_clause is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generate_create_clause"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_feature_assertions (current_: EIFFEL_CODE_GENERATOR; assertions: LINKED_LIST_ANY; keyword: STRING) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR, LINKED_LIST_ANY, STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$generate_feature_assertions"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"copy"
		end

	frozen ec_illegal_36_ec_illegal_36_is_special_class (current_: EIFFEL_CODE_GENERATOR): BOOLEAN is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$is_special_class"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"internal_copy"
		end

	closing_square_bracket: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"closing_square_bracket"
		end

	infix_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"infix_keyword"
		end

	comma: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"comma"
		end

	integer_64_class: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"integer_64_class"
		end

	from_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"from_component_string"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"generator"
		end

	frozen ec_illegal_36_ec_illegal_36_bit_or_infix_signature (current_: EIFFEL_CODE_GENERATOR): STRING is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"$$bit_or_infix_signature"
		end

	dtd_assembly_filename: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"dtd_assembly_filename"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_CODE_GENERATOR"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_EIFFEL_CODE_GENERATOR
