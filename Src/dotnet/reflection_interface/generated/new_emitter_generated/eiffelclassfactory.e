indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "EiffelClassFactory"

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

	resolve_inheritance_and_overloading is
		external
			"IL signature (): System.Void use EiffelClassFactory"
		alias
			"ResolveInheritanceAndOverloading"
		end

	generated_routine (routine_name: STRING; routine_table: SYSTEM_COLLECTIONS_HASHTABLE): STRING is
		external
			"IL signature (System.String, System.Collections.Hashtable): System.String use EiffelClassFactory"
		alias
			"GeneratedRoutine"
		end

	generate_arguments_names (routine_name: STRING; routine_table: SYSTEM_COLLECTIONS_HASHTABLE) is
		external
			"IL signature (System.String, System.Collections.Hashtable): System.Void use EiffelClassFactory"
		alias
			"GenerateArgumentsNames"
		end

	rename_children (method: EIFFELMETHODFACTORY; new_name: STRING) is
		external
			"IL signature (EiffelMethodFactory, System.String): System.Void use EiffelClassFactory"
		alias
			"RenameChildren"
		end

	resolve_creation_routine_name_clash is
		external
			"IL signature (): System.Void use EiffelClassFactory"
		alias
			"ResolveCreationRoutineNameClash"
		end

	intern_generate_arguments_names (arguments: ARRAY [SYSTEM_REFLECTION_PARAMETERINFO]; is_binary_operator: BOOLEAN): ARRAY [STRING] is
		external
			"IL signature (System.Reflection.ParameterInfo[], System.Boolean): System.String[] use EiffelClassFactory"
		alias
			"InternGenerateArgumentsNames"
		end

	generate_routines_arguments_names is
		external
			"IL signature (): System.Void use EiffelClassFactory"
		alias
			"GenerateRoutinesArgumentsNames"
		end

	is_generated_in_current (method: EIFFELMETHODFACTORY): BOOLEAN is
		external
			"IL signature (EiffelMethodFactory): System.Boolean use EiffelClassFactory"
		alias
			"IsGeneratedInCurrent"
		end

	rename_feature (parent: EIFFELCLASSFACTORY; method: EIFFELMETHODFACTORY; new_name: STRING) is
		external
			"IL signature (EiffelClassFactory, EiffelMethodFactory, System.String): System.Void use EiffelClassFactory"
		alias
			"RenameFeature"
		end

end -- class EIFFELCLASSFACTORY
