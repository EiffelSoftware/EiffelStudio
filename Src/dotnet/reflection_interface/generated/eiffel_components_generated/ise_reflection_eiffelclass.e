indexing
	Generator: "Eiffel Emitter 2.6b2"
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

	frozen is_deferred: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"IsDeferred"
		end

	frozen namespace: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelClass"
		alias
			"Namespace"
		end

	frozen element_change_features: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"ElementChangeFeatures"
		end

	frozen binary_operators_features: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"BinaryOperatorsFeatures"
		end

	frozen is_expanded: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"IsExpanded"
		end

	frozen invariants: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"Invariants"
		end

	frozen assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		external
			"IL field signature :ISE.Reflection.AssemblyDescriptor use ISE.Reflection.EiffelClass"
		alias
			"AssemblyDescriptor"
		end

	frozen parents: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.EiffelClass"
		alias
			"Parents"
		end

	frozen access_features: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"AccessFeatures"
		end

	frozen basic_operations: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"BasicOperations"
		end

	frozen special_features: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"SpecialFeatures"
		end

	frozen unary_operators_features: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"UnaryOperatorsFeatures"
		end

	frozen implementation_features: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"ImplementationFeatures"
		end

	frozen initialization_features: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"InitializationFeatures"
		end

	frozen attribute: ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL field signature :ISE.Reflection.EiffelFeature use ISE.Reflection.EiffelClass"
		alias
			"Attribute"
		end

	frozen external_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelClass"
		alias
			"ExternalName"
		end

	frozen modified: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"Modified"
		end

	frozen enum_type: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelClass"
		alias
			"EnumType"
		end

	frozen is_frozen: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"IsFrozen"
		end

	frozen full_external_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelClass"
		alias
			"FullExternalName"
		end

	frozen routine: ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL field signature :ISE.Reflection.EiffelFeature use ISE.Reflection.EiffelClass"
		alias
			"Routine"
		end

	frozen create_none: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"CreateNone"
		end

	frozen eiffel_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelClass"
		alias
			"EiffelName"
		end

	frozen creation_routines: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelClass"
		alias
			"CreationRoutines"
		end

feature -- Basic Operations

	set_deferred (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetDeferred"
		end

	add_access_feature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddAccessFeature"
		end

	matching_arguments (info: SYSTEM_REFLECTION_METHODBASE; arguments: SYSTEM_COLLECTIONS_ARRAYLIST): BOOLEAN is
		external
			"IL signature (System.Reflection.MethodBase, System.Collections.ArrayList): System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"MatchingArguments"
		end

	add_initialization_feature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddInitializationFeature"
		end

	set_external_names (a_full_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetExternalNames"
		end

	has_attribute (info: SYSTEM_REFLECTION_MEMBERINFO; a_list: SYSTEM_COLLECTIONS_ARRAYLIST): BOOLEAN is
		external
			"IL signature (System.Reflection.MemberInfo, System.Collections.ArrayList): System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"HasAttribute"
		end

	set_frozen (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetFrozen"
		end

	set_expanded (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetExpanded"
		end

	set_parents (a_table: SYSTEM_COLLECTIONS_HASHTABLE) is
		external
			"IL signature (System.Collections.Hashtable): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetParents"
		end

	frozen a_invariant (current_object: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL static signature (ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.EiffelClass"
		alias
			"_invariant"
		end

	set_eiffel_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetEiffelName"
		end

	creation_routine_from_info (info: SYSTEM_REFLECTION_CONSTRUCTORINFO): ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL signature (System.Reflection.ConstructorInfo): ISE.Reflection.EiffelFeature use ISE.Reflection.EiffelClass"
		alias
			"CreationRoutineFromInfo"
		end

	add_creation_routine (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddCreationRoutine"
		end

	has_routine (info: SYSTEM_REFLECTION_METHODBASE; a_list: SYSTEM_COLLECTIONS_ARRAYLIST): BOOLEAN is
		external
			"IL signature (System.Reflection.MethodBase, System.Collections.ArrayList): System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"HasRoutine"
		end

	add_element_change_feature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddElementChangeFeature"
		end

	add_binary_operator (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddBinaryOperator"
		end

	has_creation_routine (info: SYSTEM_REFLECTION_CONSTRUCTORINFO): BOOLEAN is
		external
			"IL signature (System.Reflection.ConstructorInfo): System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"HasCreationRoutine"
		end

	set_modified is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetModified"
		end

	intern_has_routine (eiffel_feature: ISE_REFLECTION_EIFFELFEATURE; info: SYSTEM_REFLECTION_METHODBASE): BOOLEAN is
		external
			"IL signature (ISE.Reflection.EiffelFeature, System.Reflection.MethodBase): System.Boolean use ISE.Reflection.EiffelClass"
		alias
			"InternHasRoutine"
		end

	set_create_none (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetCreateNone"
		end

	routine_from_info (info: SYSTEM_REFLECTION_METHODINFO): ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL signature (System.Reflection.MethodInfo): ISE.Reflection.EiffelFeature use ISE.Reflection.EiffelClass"
		alias
			"RoutineFromInfo"
		end

	add_parent (a_name: STRING; rename_clauses: SYSTEM_COLLECTIONS_ARRAYLIST; undefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST; redefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST; select_clauses: SYSTEM_COLLECTIONS_ARRAYLIST; export_clauses: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.String, System.Collections.ArrayList, System.Collections.ArrayList, System.Collections.ArrayList, System.Collections.ArrayList, System.Collections.ArrayList): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddParent"
		end

	add_special_feature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddSpecialFeature"
		end

	set_full_external_name (a_full_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetFullExternalName"
		end

	add_invariant (a_tag: STRING; a_text: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddInvariant"
		end

	attribute_from_info (info: SYSTEM_REFLECTION_MEMBERINFO): ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL signature (System.Reflection.MemberInfo): ISE.Reflection.EiffelFeature use ISE.Reflection.EiffelClass"
		alias
			"AttributeFromInfo"
		end

	set_external_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetExternalName"
		end

	set_namespace (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetNamespace"
		end

	add_implementation_feature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddImplementationFeature"
		end

	set_assembly_descriptor (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetAssemblyDescriptor"
		end

	set_enum_type (an_enum_type: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelClass"
		alias
			"SetEnumType"
		end

	add_unary_operator (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddUnaryOperator"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelClass"
		alias
			"Make"
		end

	add_basic_operation (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelClass"
		alias
			"AddBasicOperation"
		end

end -- class ISE_REFLECTION_EIFFELCLASS
