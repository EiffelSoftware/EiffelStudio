indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.XmlElements"
	assembly: "ISE.Reflection.Support", "0.0.0.0", "neutral", "2ef5239aeb372f26"

external class
	ISE_REFLECTION_XMLELEMENTS

inherit
	ISE_REFLECTION_DICTIONARY

create
	make_xmlelements

feature {NONE} -- Initialization

	frozen make_xmlelements is
		external
			"IL creator use ISE.Reflection.XmlElements"
		end

feature -- Basic Operations

	method_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"MethodElement"
		end

	postcondition_text_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"PostconditionTextElement"
		end

	prefix_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"PrefixElement"
		end

	frozen_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"FrozenElement"
		end

	frozen_feature_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"FrozenFeatureElement"
		end

	assembly_name_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"AssemblyNameElement"
		end

	assembly_version_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"AssemblyVersionElement"
		end

	simple_name_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"SimpleNameElement"
		end

	assembly_public_key_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"AssemblyPublicKeyElement"
		end

	emitter_version_number_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"EmitterVersionNumberElement"
		end

	create_none_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"CreateNoneElement"
		end

	derivation_types_count_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"DerivationTypesCountElement"
		end

	argument_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ArgumentElement"
		end

	argument_external_name_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ArgumentExternalNameElement"
		end

	argument_type_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ArgumentTypeElement"
		end

	precondition_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"PreconditionElement"
		end

	modified_feature_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ModifiedFeatureElement"
		end

	invariants_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"InvariantsElement"
		end

	creation_routine_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"CreationRoutineElement"
		end

	eiffel_cluster_path_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"EiffelClusterPathElement"
		end

	argument_type_full_name_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ArgumentTypeFullNameElement"
		end

	return_type_full_name_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ReturnTypeFullNameElement"
		end

	inherit_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"InheritElement"
		end

	bit_or_infix_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"BitOrInfixElement"
		end

	body_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"BodyElement"
		end

	invariant_text_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"InvariantTextElement"
		end

	static_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"StaticElement"
		end

	infix_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"InfixElement"
		end

	alias_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"AliasElement"
		end

	enum_literal_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"EnumLiteralElement"
		end

	assembly_filename_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"AssemblyFilenameElement"
		end

	feature_external_name_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"FeatureExternalNameElement"
		end

	create_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"CreateElement"
		end

	modified_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ModifiedElement"
		end

	feature_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"FeatureElement"
		end

	postconditions_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"PostconditionsElement"
		end

	generic_type_eiffel_name_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"GenericTypeEiffelNameElement"
		end

	assembly_type_filename_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"AssemblyTypeFilenameElement"
		end

	namespace_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"NamespaceElement"
		end

	deferred_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"DeferredElement"
		end

	access_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"AccessElement"
		end

	constraint_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ConstraintElement"
		end

	postcondition_tag_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"PostconditionTagElement"
		end

	class_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ClassElement"
		end

	feature_eiffel_name_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"FeatureEiffelNameElement"
		end

	specials_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"SpecialsElement"
		end

	postcondition_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"PostconditionElement"
		end

	argument_eiffel_name_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ArgumentEiffelNameElement"
		end

	precondition_text_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"PreconditionTextElement"
		end

	assemblies_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"AssembliesElement"
		end

	rename_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"RenameElement"
		end

	abstract_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"AbstractElement"
		end

	is_literal_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"IsLiteralElement"
		end

	parent_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ParentElement"
		end

	basic_operations_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"BasicOperationsElement"
		end

	class_eiffel_name_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ClassEiffelNameElement"
		end

	field_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"FieldElement"
		end

	return_type_generic_parameter_index_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ReturnTypeGenericParameterIndexElement"
		end

	new_slot_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"NewSlotElement"
		end

	element_change_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ElementChangeElement"
		end

	preconditions_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"PreconditionsElement"
		end

	parent_name_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ParentNameElement"
		end

	generic_derivation_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"GenericDerivationElement"
		end

	arguments_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ArgumentsElement"
		end

	literal_value_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"LiteralValueElement"
		end

	undefine_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"UndefineElement"
		end

	redefine_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"RedefineElement"
		end

	generic_parameter_index_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"GenericParameterIndexElement"
		end

	footer_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"FooterElement"
		end

	select_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"SelectElement"
		end

	enum_type_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"EnumTypeElement"
		end

	invariant_tag_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"InvariantTagElement"
		end

	binary_operators_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"BinaryOperatorsElement"
		end

	generic_derivations_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"GenericDerivationsElement"
		end

	comments_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"CommentsElement"
		end

	generic_type_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"GenericTypeElement"
		end

	invariant_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"InvariantElement"
		end

	constraints_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ConstraintsElement"
		end

	export_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ExportElement"
		end

	assembly_types_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"AssemblyTypesElement"
		end

	return_type_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ReturnTypeElement"
		end

	generic_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"GenericElement"
		end

	precondition_tag_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"PreconditionTagElement"
		end

	unary_operators_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"UnaryOperatorsElement"
		end

	assembly_culture_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"AssemblyCultureElement"
		end

	assembly_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"AssemblyElement"
		end

	expanded_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ExpandedElement"
		end

	implementation_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"ImplementationElement"
		end

	generic_type_external_name_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"GenericTypeExternalNameElement"
		end

	initialization_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"InitializationElement"
		end

	header_element: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.XmlElements"
		alias
			"HeaderElement"
		end

end -- class ISE_REFLECTION_XMLELEMENTS
