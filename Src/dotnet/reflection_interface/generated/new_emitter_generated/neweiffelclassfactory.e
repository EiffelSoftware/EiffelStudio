indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "NewEiffelClassFactory"

external class
	NEWEIFFELCLASSFACTORY

inherit
	NEWGLOBALS

create
	make_neweiffelclassfactory

feature {NONE} -- Initialization

	frozen make_neweiffelclassfactory (ClassID: INTEGER; aType: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Int32, System.Type) use NewEiffelClassFactory"
		end

feature {NONE} -- Implementation

	ResolveInheritanceAndOverloading is
		external
			"IL signature (): System.Void use NewEiffelClassFactory"
		alias
			"ResolveInheritanceAndOverloading"
		end

	GeneratedRoutine (RoutineName: STRING; RoutineTable: SYSTEM_COLLECTIONS_HASHTABLE): STRING is
		external
			"IL signature (System.String, System.Collections.Hashtable): System.String use NewEiffelClassFactory"
		alias
			"GeneratedRoutine"
		end

	GenerateArgumentsNames (RoutineName: STRING; RoutineTable: SYSTEM_COLLECTIONS_HASHTABLE) is
		external
			"IL signature (System.String, System.Collections.Hashtable): System.Void use NewEiffelClassFactory"
		alias
			"GenerateArgumentsNames"
		end

	RenameChildren (Method: NEWEIFFELMETHODFACTORY; NewName: STRING) is
		external
			"IL signature (NewEiffelMethodFactory, System.String): System.Void use NewEiffelClassFactory"
		alias
			"RenameChildren"
		end

	ResolveCreationRoutineNameClash is
		external
			"IL signature (): System.Void use NewEiffelClassFactory"
		alias
			"ResolveCreationRoutineNameClash"
		end

	InternGenerateArgumentsNames (Arguments: ARRAY [SYSTEM_REFLECTION_PARAMETERINFO]; IsBinaryOperator: BOOLEAN): ARRAY [STRING] is
		external
			"IL signature (System.Reflection.ParameterInfo[], System.Boolean): System.String[] use NewEiffelClassFactory"
		alias
			"InternGenerateArgumentsNames"
		end

	GenerateRoutinesArgumentsNames is
		external
			"IL signature (): System.Void use NewEiffelClassFactory"
		alias
			"GenerateRoutinesArgumentsNames"
		end

	IsGeneratedInCurrent (Method: NEWEIFFELMETHODFACTORY): BOOLEAN is
		external
			"IL signature (NewEiffelMethodFactory): System.Boolean use NewEiffelClassFactory"
		alias
			"IsGeneratedInCurrent"
		end

	RenameFeature (Parent: NEWEIFFELCLASSFACTORY; Method: NEWEIFFELMETHODFACTORY; NewName: STRING) is
		external
			"IL signature (NewEiffelClassFactory, NewEiffelMethodFactory, System.String): System.Void use NewEiffelClassFactory"
		alias
			"RenameFeature"
		end

end -- class NEWEIFFELCLASSFACTORY
