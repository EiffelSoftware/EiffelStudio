indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "ISE.Reflection.EiffelClass"

external class
	ISE_REFLECTION_EIFFELCLASS

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.EiffelClass"
		end

feature -- Access

	frozen IsExpanded: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"IsExpanded"
		end

	frozen UnaryOperatorsFeatures: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"UnaryOperatorsFeatures"
		end

	frozen EiffelName: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelClass"
		alias
			"EiffelName"
		end

	frozen Parents: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.EiffelClass"
		alias
			"Parents"
		end

	frozen ImplementationFeatures: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"ImplementationFeatures"
		end

	frozen InitializationFeatures: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"InitializationFeatures"
		end

	frozen FullExternalName: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelClass"
		alias
			"FullExternalName"
		end

	frozen Invariants: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"Invariants"
		end

	frozen Attribute: ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL field signature :ISE.Reflection.EiffelFeature use ISE.Reflection.EiffelClass"
		alias
			"Attribute"
		end

	frozen AssemblyDescriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		external
			"IL field signature :ISE.Reflection.AssemblyDescriptor use ISE.Reflection.EiffelClass"
		alias
			"AssemblyDescriptor"
		end

	frozen IsDeferred: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"IsDeferred"
		end

	frozen SpecialFeatures: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"SpecialFeatures"
		end

	frozen IsFrozen: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"IsFrozen"
		end

	frozen ExternalName: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelClass"
		alias
			"ExternalName"
		end

	frozen CreateNone: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"CreateNone"
		end

	frozen CreationRoutines: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"CreationRoutines"
		end

	frozen Namespace: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelClass"
		alias
			"Namespace"
		end

	frozen Routine: ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL field signature :ISE.Reflection.EiffelFeature use ISE.Reflection.EiffelClass"
		alias
			"Routine"
		end

	frozen AccessFeatures: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"AccessFeatures"
		end

	frozen BinaryOperatorsFeatures: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"BinaryOperatorsFeatures"
		end

	frozen ElementChangeFeatures: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"ElementChangeFeatures"
		end

	frozen BasicOperations: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"BasicOperations"
		end

feature -- Basic Operations

	AddInitializationFeature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddInitializationFeature"
		end

	SetDeferred (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetDeferred"
		end

	AddBinaryOperator (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddBinaryOperator"
		end

	HasCreationRoutine (info: SYSTEM_REFLECTION_CONSTRUCTORINFO): BOOLEAN is
		external
			"IL signature (System.Reflection.ConstructorInfo): System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"HasCreationRoutine"
		end

	AddBasicOperation (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddBasicOperation"
		end

	AttributeFromInfo (info: SYSTEM_REFLECTION_MEMBERINFO): ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL signature (System.Reflection.MemberInfo): ISE.Reflection.EiffelFeature use ISE.Reflection.EiffelClass"
		alias
			"AttributeFromInfo"
		end

	AddInvariant (a_tag: STRING; a_text: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddInvariant"
		end

	SetExternalNames (a_full_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetExternalNames"
		end

	HasAttribute (info: SYSTEM_REFLECTION_MEMBERINFO; a_list: SYSTEM_COLLECTIONS_ARRAYLIST): BOOLEAN is
		external
			"IL signature (System.Reflection.MemberInfo, System.Collections.ArrayList): System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"HasAttribute"
		end

	SetAssemblyDescriptor (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetAssemblyDescriptor"
		end

	AddElementChangeFeature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddElementChangeFeature"
		end

	AddUnaryOperator (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddUnaryOperator"
		end

	SetExpanded (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetExpanded"
		end

	AddAccessFeature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddAccessFeature"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelClass"
		alias
			"_invariant"
		end

	MatchingArguments (info: SYSTEM_REFLECTION_METHODBASE; arguments: SYSTEM_COLLECTIONS_ARRAYLIST): BOOLEAN is
		external
			"IL signature (System.Reflection.MethodBase, System.Collections.ArrayList): System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"MatchingArguments"
		end

	HasRoutine (info: SYSTEM_REFLECTION_METHODBASE; a_list: SYSTEM_COLLECTIONS_ARRAYLIST): BOOLEAN is
		external
			"IL signature (System.Reflection.MethodBase, System.Collections.ArrayList): System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"HasRoutine"
		end

	SetExternalName (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetExternalName"
		end

	SetEiffelName (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetEiffelName"
		end

	AddCreationRoutine (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddCreationRoutine"
		end

	Make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelClass"
		alias
			"Make"
		end

	SetFrozen (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetFrozen"
		end

	AddParent (a_name: STRING; rename_clauses: SYSTEM_COLLECTIONS_ARRAYLIST; undefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST; redefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST; select_clauses: SYSTEM_COLLECTIONS_ARRAYLIST; export_clauses: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.String, System.Collections.ArrayList, System.Collections.ArrayList, System.Collections.ArrayList, System.Collections.ArrayList, System.Collections.ArrayList): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddParent"
		end

	AddImplementationFeature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddImplementationFeature"
		end

	RoutineFromInfo (info: SYSTEM_REFLECTION_METHODINFO): ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL signature (System.Reflection.MethodInfo): ISE.Reflection.EiffelFeature use ISE.Reflection.EiffelClass"
		alias
			"RoutineFromInfo"
		end

	SetCreateNone (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetCreateNone"
		end

	CreationRoutineFromInfo (info: SYSTEM_REFLECTION_CONSTRUCTORINFO): ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL signature (System.Reflection.ConstructorInfo): ISE.Reflection.EiffelFeature use ISE.Reflection.EiffelClass"
		alias
			"CreationRoutineFromInfo"
		end

	InternHasRoutine (eiffel_feature: ISE_REFLECTION_EIFFELFEATURE; info: SYSTEM_REFLECTION_METHODBASE): BOOLEAN is
		external
			"IL signature (ISE.Reflection.EiffelFeature, System.Reflection.MethodBase): System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"InternHasRoutine"
		end

	SetFullExternalName (a_full_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetFullExternalName"
		end

	SetNamespace (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetNamespace"
		end

	AddSpecialFeature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddSpecialFeature"
		end

end -- class ISE_REFLECTION_EIFFELCLASS
