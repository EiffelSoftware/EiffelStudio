indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "EiffelClassFactory"

external class
	EIFFEL_CLASS_FACTORY

inherit
	GLOBALS

create
	make_eiffel_class_factory

feature {NONE} -- Initialization

	frozen make_eiffel_class_factory (class_id: INTEGER; a_type: TYPE) is
		external
			"IL creator signature (System.Int32, System.Type) use EiffelClassFactory"
		end

feature {NONE} -- Implementation

	generated_routine (routine_name: SYSTEM_STRING; routine_table: HASHTABLE): SYSTEM_STRING is
		external
			"IL signature (System.String, System.Collections.Hashtable): System.String use EiffelClassFactory"
		alias
			"GeneratedRoutine"
		end

	generate_binary_operators_arguments_names (routine_name: SYSTEM_STRING; routine_table: HASHTABLE) is
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

	generate_arguments_names (routine_name: SYSTEM_STRING; routine_table: HASHTABLE) is
		external
			"IL signature (System.String, System.Collections.Hashtable): System.Void use EiffelClassFactory"
		alias
			"GenerateArgumentsNames"
		end

	rename_feature (parent: EIFFEL_CLASS_FACTORY; method: EIFFEL_METHOD_FACTORY; new_name: SYSTEM_STRING) is
		external
			"IL signature (EiffelClassFactory, EiffelMethodFactory, System.String): System.Void use EiffelClassFactory"
		alias
			"RenameFeature"
		end

	intern_generate_arguments_names (arguments: NATIVE_ARRAY [PARAMETER_INFO]; is_binary_operator: BOOLEAN): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (System.Reflection.ParameterInfo[], System.Boolean): System.String[] use EiffelClassFactory"
		alias
			"InternGenerateArgumentsNames"
		end

	generate_creation_routine_arguments_names (routine_name: SYSTEM_STRING; routine_table: HASHTABLE) is
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

	rename_children (method: EIFFEL_METHOD_FACTORY; new_name: SYSTEM_STRING) is
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

	frozen decode_key (key: NATIVE_ARRAY [INTEGER_8]): SYSTEM_STRING is
		external
			"IL signature (System.Byte[]): System.String use EiffelClassFactory"
		alias
			"DecodeKey"
		end

end -- class EIFFEL_CLASS_FACTORY
