indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "EiffelClassFactory"
	assembly: "ISE.Reflection.Emitter", "1.0.0.62252", "neutral", "30914072a1caac"

external class
	EIFFELCLASSFACTORY

inherit
	GLOBALS

create
	make_eiffelclassfactory

feature {NONE} -- Initialization

	frozen make_eiffelclassfactory (class_id: INTEGER; a_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Int32, System.Type) use EiffelClassFactory"
		end

feature {NONE} -- Implementation

	generated_routine (routine_name: STRING; routine_table: SYSTEM_COLLECTIONS_HASHTABLE): STRING is
		external
			"IL signature (System.String, System.Collections.Hashtable): System.String use EiffelClassFactory"
		alias
			"GeneratedRoutine"
		end

	generate_binary_operators_arguments_names (routine_name: STRING; routine_table: SYSTEM_COLLECTIONS_HASHTABLE) is
		external
			"IL signature (System.String, System.Collections.Hashtable): System.Void use EiffelClassFactory"
		alias
			"GenerateBinaryOperatorsArgumentsNames"
		end

	resolve_creation_routine_name_clash is
		external
			"IL signature (): System.Void use EiffelClassFactory"
		alias
			"ResolveCreationRoutineNameClash"
		end

	generate_arguments_names (routine_name: STRING; routine_table: SYSTEM_COLLECTIONS_HASHTABLE) is
		external
			"IL signature (System.String, System.Collections.Hashtable): System.Void use EiffelClassFactory"
		alias
			"GenerateArgumentsNames"
		end

	rename_feature (parent: EIFFELCLASSFACTORY; method: EIFFELMETHODFACTORY; new_name: STRING) is
		external
			"IL signature (EiffelClassFactory, EiffelMethodFactory, System.String): System.Void use EiffelClassFactory"
		alias
			"RenameFeature"
		end

	intern_generate_arguments_names (arguments: ARRAY [SYSTEM_REFLECTION_PARAMETERINFO]; is_binary_operator: BOOLEAN): ARRAY [STRING] is
		external
			"IL signature (System.Reflection.ParameterInfo[], System.Boolean): System.String[] use EiffelClassFactory"
		alias
			"InternGenerateArgumentsNames"
		end

	generate_creation_routine_arguments_names (routine_name: STRING; routine_table: SYSTEM_COLLECTIONS_HASHTABLE) is
		external
			"IL signature (System.String, System.Collections.Hashtable): System.Void use EiffelClassFactory"
		alias
			"GenerateCreationRoutineArgumentsNames"
		end

	resolve_inheritance_and_overloading is
		external
			"IL signature (): System.Void use EiffelClassFactory"
		alias
			"ResolveInheritanceAndOverloading"
		end

	rename_children (method: EIFFELMETHODFACTORY; new_name: STRING) is
		external
			"IL signature (EiffelMethodFactory, System.String): System.Void use EiffelClassFactory"
		alias
			"RenameChildren"
		end

	generate_routines_arguments_names is
		external
			"IL signature (): System.Void use EiffelClassFactory"
		alias
			"GenerateRoutinesArgumentsNames"
		end

	frozen decode_key (key: ARRAY [INTEGER_8]): STRING is
		external
			"IL signature (System.Byte[]): System.String use EiffelClassFactory"
		alias
			"DecodeKey"
		end

end -- class EIFFELCLASSFACTORY
