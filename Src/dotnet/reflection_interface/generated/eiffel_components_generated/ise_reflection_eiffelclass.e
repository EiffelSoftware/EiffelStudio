indexing
	Generator: "Eiffel Emitter beta 2"
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

	frozen isfrozen: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"IsFrozen"
		end

	frozen accessfeatures: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"AccessFeatures"
		end

	frozen namespace: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelClass"
		alias
			"Namespace"
		end

	frozen invariants: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"Invariants"
		end

	frozen isexpanded: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"IsExpanded"
		end

	frozen dotnetsimplename: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelClass"
		alias
			"DotNetSimpleName"
		end

	frozen creationroutines: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"CreationRoutines"
		end

	frozen assemblydescriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		external
			"IL field signature :ISE.Reflection.AssemblyDescriptor use ISE.Reflection.EiffelClass"
		alias
			"AssemblyDescriptor"
		end

	frozen elementchangefeatures: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"ElementChangeFeatures"
		end

	frozen isdeferred: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"IsDeferred"
		end

	frozen initializationfeatures: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"InitializationFeatures"
		end

	frozen basicoperations: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"BasicOperations"
		end

	frozen createnone: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"CreateNone"
		end

	frozen unaryoperatorsfeatures: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"UnaryOperatorsFeatures"
		end

	frozen attribute: ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL field signature :ISE.Reflection.EiffelFeature use ISE.Reflection.EiffelClass"
		alias
			"Attribute"
		end

	frozen routine: ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL field signature :ISE.Reflection.EiffelFeature use ISE.Reflection.EiffelClass"
		alias
			"Routine"
		end

	frozen dotnetfullname: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelClass"
		alias
			"DotNetFullName"
		end

	frozen specialfeatures: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"SpecialFeatures"
		end

	frozen parents: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.EiffelClass"
		alias
			"Parents"
		end

	frozen binaryoperatorsfeatures: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"BinaryOperatorsFeatures"
		end

	frozen implementationfeatures: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"ImplementationFeatures"
		end

	frozen eiffelname: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelClass"
		alias
			"EiffelName"
		end

feature -- Basic Operations

	hasattribute (info: SYSTEM_REFLECTION_MEMBERINFO; a_list: SYSTEM_COLLECTIONS_ARRAYLIST): BOOLEAN is
		external
			"IL signature (System.Reflection.MemberInfo, System.Collections.ArrayList): System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"HasAttribute"
		end

	addcreationroutine (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddCreationRoutine"
		end

	creationroutinefrominfo (info: SYSTEM_REFLECTION_CONSTRUCTORINFO): ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL signature (System.Reflection.ConstructorInfo): ISE.Reflection.EiffelFeature use ISE.Reflection.EiffelClass"
		alias
			"CreationRoutineFromInfo"
		end

	addbinaryoperator (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddBinaryOperator"
		end

	setfrozen (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetFrozen"
		end

	addaccessfeature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddAccessFeature"
		end

	setdotnetfullname (a_full_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetDotNetFullName"
		end

	addimplementationfeature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddImplementationFeature"
		end

	setdotnetsimplename (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetDotNetSimpleName"
		end

	setnamespace (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetNamespace"
		end

	addinvariant (a_tag: STRING; a_text: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddInvariant"
		end

	setcreatenone (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetCreateNone"
		end

	setassemblydescriptor (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetAssemblyDescriptor"
		end

	setexpanded (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetExpanded"
		end

	internhasroutine (eiffel_feature: ISE_REFLECTION_EIFFELFEATURE; info: SYSTEM_REFLECTION_METHODBASE): BOOLEAN is
		external
			"IL signature (ISE.Reflection.EiffelFeature, System.Reflection.MethodBase): System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"InternHasRoutine"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelClass"
		alias
			"_invariant"
		end

	matchingarguments (info: SYSTEM_REFLECTION_METHODBASE; arguments: SYSTEM_COLLECTIONS_ARRAYLIST): BOOLEAN is
		external
			"IL signature (System.Reflection.MethodBase, System.Collections.ArrayList): System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"MatchingArguments"
		end

	attributefrominfo (info: SYSTEM_REFLECTION_MEMBERINFO): ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL signature (System.Reflection.MemberInfo): ISE.Reflection.EiffelFeature use ISE.Reflection.EiffelClass"
		alias
			"AttributeFromInfo"
		end

	seteiffelname (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetEiffelName"
		end

	addparent (a_name: STRING; rename_clauses: SYSTEM_COLLECTIONS_ARRAYLIST; undefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST; redefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST; select_clauses: SYSTEM_COLLECTIONS_ARRAYLIST; export_clauses: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.String, System.Collections.ArrayList, System.Collections.ArrayList, System.Collections.ArrayList, System.Collections.ArrayList, System.Collections.ArrayList): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddParent"
		end

	addbasicoperation (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddBasicOperation"
		end

	setdeferred (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetDeferred"
		end

	routinefrominfo (info: SYSTEM_REFLECTION_METHODINFO): ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL signature (System.Reflection.MethodInfo): ISE.Reflection.EiffelFeature use ISE.Reflection.EiffelClass"
		alias
			"RoutineFromInfo"
		end

	addunaryoperator (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddUnaryOperator"
		end

	setfullname (a_full_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetFullName"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelClass"
		alias
			"Make"
		end

	addinitializationfeature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddInitializationFeature"
		end

	hascreationroutine (info: SYSTEM_REFLECTION_CONSTRUCTORINFO): BOOLEAN is
		external
			"IL signature (System.Reflection.ConstructorInfo): System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"HasCreationRoutine"
		end

	hasroutine (info: SYSTEM_REFLECTION_METHODBASE; a_list: SYSTEM_COLLECTIONS_ARRAYLIST): BOOLEAN is
		external
			"IL signature (System.Reflection.MethodBase, System.Collections.ArrayList): System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"HasRoutine"
		end

	addelementchangefeature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddElementChangeFeature"
		end

	addspecialfeature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddSpecialFeature"
		end

end -- class ISE_REFLECTION_EIFFELCLASS
