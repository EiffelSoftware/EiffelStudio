indexing
	Generator: "Eiffel Emitter 2.6b2"
	external_name: "ISE.Reflection.EiffelCodeGenerator"
external class
	ISE_REFLECTION_EIFFELCODEGENERATOR

inherit
	ISE_REFLECTION_EIFFELCODEGENERATORDICTIONARY

create
	make_eiffelcodegenerator

feature {NONE} -- Initialization

	frozen make_eiffelcodegenerator is
		external
			"IL creator use ISE.Reflection.EiffelCodeGenerator"
		end

feature -- Access

	frozen eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL field signature :ISE.Reflection.EiffelAssembly use ISE.Reflection.EiffelCodeGenerator"
		alias
			"EiffelAssembly"
		end

	frozen eiffel_class: ISE_REFLECTION_EIFFELCLASS is
		external
			"IL field signature :ISE.Reflection.EiffelClass use ISE.Reflection.EiffelCodeGenerator"
		alias
			"EiffelClass"
		end

	frozen generated_code: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GeneratedCode"
		end

	frozen parents: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.EiffelCodeGenerator"
		alias
			"Parents"
		end

	frozen special_classes: ARRAY [STRING] is
		external
			"IL field signature :System.String[] use ISE.Reflection.EiffelCodeGenerator"
		alias
			"SpecialClasses"
		end

feature -- Basic Operations

	generate_feature_assertions (assertions: SYSTEM_COLLECTIONS_ARRAYLIST; keyword: STRING) is
		external
			"IL signature (System.Collections.ArrayList, System.String): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateFeatureAssertions"
		end

	generate_inheritance_clauses (clauses: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateInheritanceClauses"
		end

	generate_eiffel_feature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateEiffelFeature"
		end

	feature_signature (a_feature: ISE_REFLECTION_EIFFELFEATURE): STRING is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.String use ISE.Reflection.EiffelCodeGenerator"
		alias
			"FeatureSignature"
		end

	intern_generate_class_features (a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"InternGenerateClassFeatures"
		end

	make_from_info (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY) is
		external
			"IL signature (ISE.Reflection.EiffelAssembly): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"MakeFromInfo"
		end

	generate_inherit_clause is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateInheritClause"
		end

	intern_generate_eiffel_class (a_filename: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"InternGenerateEiffelClass"
		end

	make_eiffel_code_generator is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"MakeEiffelCodeGenerator"
		end

	has_any_undefine: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.EiffelCodeGenerator"
		alias
			"HasAnyUndefine"
		end

	has_any_rename: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.EiffelCodeGenerator"
		alias
			"HasAnyRename"
		end

	generate_eiffel_class_from_path (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS; a_path: STRING) is
		external
			"IL signature (ISE.Reflection.EiffelClass, System.String): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateEiffelClassFromPath"
		end

	is_special_class: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.EiffelCodeGenerator"
		alias
			"IsSpecialClass"
		end

	generate_class_features is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateClassFeatures"
		end

	has_any_redefine: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.EiffelCodeGenerator"
		alias
			"HasAnyRedefine"
		end

	generate_eiffel_class (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL signature (ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateEiffelClass"
		end

	generate_create_clause is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateCreateClause"
		end

	generate_external_clause (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateExternalClause"
		end

end -- class ISE_REFLECTION_EIFFELCODEGENERATOR
