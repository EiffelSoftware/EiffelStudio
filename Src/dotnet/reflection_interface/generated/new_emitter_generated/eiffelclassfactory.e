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

	frozen make_eiffelclassfactory (ClassID: INTEGER; aType: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Int32, System.Type) use EiffelClassFactory"
		end

feature {NONE} -- Implementation

	ResolveInheritanceAndOverloading is
		external
			"IL signature (): System.Void use EiffelClassFactory"
		alias
			"ResolveInheritanceAndOverloading"
		end

	GeneratedRoutine (RoutineName: STRING; RoutineTable: SYSTEM_COLLECTIONS_HASHTABLE): STRING is
		external
			"IL signature (System.String, System.Collections.Hashtable): System.String use EiffelClassFactory"
		alias
			"GeneratedRoutine"
		end

	GenerateArgumentsNames (RoutineName: STRING; RoutineTable: SYSTEM_COLLECTIONS_HASHTABLE) is
		external
			"IL signature (System.String, System.Collections.Hashtable): System.Void use EiffelClassFactory"
		alias
			"GenerateArgumentsNames"
		end

	RenameChildren (Method: EIFFELMETHODFACTORY; NewName: STRING) is
		external
			"IL signature (EiffelMethodFactory, System.String): System.Void use EiffelClassFactory"
		alias
			"RenameChildren"
		end

	ResolveCreationRoutineNameClash is
		external
			"IL signature (): System.Void use EiffelClassFactory"
		alias
			"ResolveCreationRoutineNameClash"
		end

	InternGenerateArgumentsNames (Arguments: ARRAY [SYSTEM_REFLECTION_PARAMETERINFO]; IsBinaryOperator: BOOLEAN): ARRAY [STRING] is
		external
			"IL signature (System.Reflection.ParameterInfo[], System.Boolean): System.String[] use EiffelClassFactory"
		alias
			"InternGenerateArgumentsNames"
		end

	GenerateRoutinesArgumentsNames is
		external
			"IL signature (): System.Void use EiffelClassFactory"
		alias
			"GenerateRoutinesArgumentsNames"
		end

	IsGeneratedInCurrent (Method: EIFFELMETHODFACTORY): BOOLEAN is
		external
			"IL signature (EiffelMethodFactory): System.Boolean use EiffelClassFactory"
		alias
			"IsGeneratedInCurrent"
		end

	RenameFeature (Parent: EIFFELCLASSFACTORY; Method: EIFFELMETHODFACTORY; NewName: STRING) is
		external
			"IL signature (EiffelClassFactory, EiffelMethodFactory, System.String): System.Void use EiffelClassFactory"
		alias
			"RenameFeature"
		end

end -- class EIFFELCLASSFACTORY
