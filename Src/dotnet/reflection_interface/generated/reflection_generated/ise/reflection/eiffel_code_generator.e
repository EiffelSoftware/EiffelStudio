indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "EIFFEL_CODE_GENERATOR"

deferred external class
	EIFFEL_CODE_GENERATOR

inherit
	CODE_GENERATOR_SUPPORT
	DICTIONARY
	EIFFEL_CODE_GENERATOR_DICTIONARY

feature -- Basic Operations

	a_set_parents (parents2: HASH_TABLE_ANY_ANY) is
		external
			"IL deferred signature (HASH_TABLE_ANY_ANY): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"_set_parents"
		end

	parents: HASH_TABLE_ANY_ANY is
		external
			"IL deferred signature (): HASH_TABLE_ANY_ANY use EIFFEL_CODE_GENERATOR"
		alias
			"parents"
		end

	a_set_eiffel_class (eiffel_class2: EIFFEL_CLASS) is
		external
			"IL deferred signature (EIFFEL_CLASS): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"_set_eiffel_class"
		end

	generated_code: STRING is
		external
			"IL deferred signature (): STRING use EIFFEL_CODE_GENERATOR"
		alias
			"generated_code"
		end

	generate_eiffel_feature (a_feature: EIFFEL_FEATURE) is
		external
			"IL deferred signature (EIFFEL_FEATURE): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"generate_eiffel_feature"
		end

	make_eiffel_code_generator is
		external
			"IL deferred signature (): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"make_eiffel_code_generator"
		end

	intern_generate_class_features (a_list: LINKED_LIST_ANY) is
		external
			"IL deferred signature (LINKED_LIST_ANY): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"intern_generate_class_features"
		end

	generate_inheritance_clauses (clauses: LINKED_LIST_ANY) is
		external
			"IL deferred signature (LINKED_LIST_ANY): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"generate_inheritance_clauses"
		end

	built_in_comment: STRING is
		external
			"IL deferred signature (): STRING use EIFFEL_CODE_GENERATOR"
		alias
			"built_in_comment"
		end

	generate_generic_clauses is
		external
			"IL deferred signature (): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"generate_generic_clauses"
		end

	generate_inherit_clause is
		external
			"IL deferred signature (): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"generate_inherit_clause"
		end

	generate_constraints is
		external
			"IL deferred signature (): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"generate_constraints"
		end

	a_set_generated_code (generated_code2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"_set_generated_code"
		end

	eiffel_class: EIFFEL_CLASS is
		external
			"IL deferred signature (): EIFFEL_CLASS use EIFFEL_CODE_GENERATOR"
		alias
			"eiffel_class"
		end

	intern_generate_eiffel_class (a_filename: STRING) is
		external
			"IL deferred signature (STRING): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"intern_generate_eiffel_class"
		end

	has_any_undefine: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use EIFFEL_CODE_GENERATOR"
		alias
			"has_any_undefine"
		end

	has_any_rename: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use EIFFEL_CODE_GENERATOR"
		alias
			"has_any_rename"
		end

	generate_eiffel_class_from_path (an_eiffel_class: EIFFEL_CLASS; a_path: STRING) is
		external
			"IL deferred signature (EIFFEL_CLASS, STRING): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"generate_eiffel_class_from_path"
		end

	special_classes: HASH_TABLE_ANY_ANY is
		external
			"IL deferred signature (): HASH_TABLE_ANY_ANY use EIFFEL_CODE_GENERATOR"
		alias
			"special_classes"
		end

	make_from_info (an_eiffel_assembly: EIFFEL_ASSEMBLY) is
		external
			"IL deferred signature (EIFFEL_ASSEMBLY): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"make_from_info"
		end

	is_special_class: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use EIFFEL_CODE_GENERATOR"
		alias
			"is_special_class"
		end

	generate_class_features is
		external
			"IL deferred signature (): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"generate_class_features"
		end

	bit_or_infix_code: STRING is
		external
			"IL deferred signature (): STRING use EIFFEL_CODE_GENERATOR"
		alias
			"bit_or_infix_code"
		end

	a_set_eiffel_assembly (eiffel_assembly2: EIFFEL_ASSEMBLY) is
		external
			"IL deferred signature (EIFFEL_ASSEMBLY): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"_set_eiffel_assembly"
		end

	bit_or_infix_signature: STRING is
		external
			"IL deferred signature (): STRING use EIFFEL_CODE_GENERATOR"
		alias
			"bit_or_infix_signature"
		end

	eiffel_assembly: EIFFEL_ASSEMBLY is
		external
			"IL deferred signature (): EIFFEL_ASSEMBLY use EIFFEL_CODE_GENERATOR"
		alias
			"eiffel_assembly"
		end

	has_any_redefine: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use EIFFEL_CODE_GENERATOR"
		alias
			"has_any_redefine"
		end

	generate_eiffel_class (an_eiffel_class: EIFFEL_CLASS) is
		external
			"IL deferred signature (EIFFEL_CLASS): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"generate_eiffel_class"
		end

	generate_generic_types is
		external
			"IL deferred signature (): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"generate_generic_types"
		end

	generate_feature_assertions (assertions: LINKED_LIST_ANY; keyword: STRING) is
		external
			"IL deferred signature (LINKED_LIST_ANY, STRING): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"generate_feature_assertions"
		end

	feature_signature (a_feature: EIFFEL_FEATURE): STRING is
		external
			"IL deferred signature (EIFFEL_FEATURE): STRING use EIFFEL_CODE_GENERATOR"
		alias
			"feature_signature"
		end

	generate_create_clause is
		external
			"IL deferred signature (): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"generate_create_clause"
		end

	generate_external_clause (a_feature: EIFFEL_FEATURE) is
		external
			"IL deferred signature (EIFFEL_FEATURE): System.Void use EIFFEL_CODE_GENERATOR"
		alias
			"generate_external_clause"
		end

end -- class EIFFEL_CODE_GENERATOR
