indexing
	description: "XML elements names for assembly and type decription xml files"
	external_name: "ISE.Reflection.XmlElements"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	XML_ELEMENTS

inherit
	DICTIONARY

		
feature -- Access
		
	Assemblies_element: STRING is "assemblies"
		indexing
			description: "Assemblies element in `index.xml'"
			external_name: "AssembliesElement"
		end
			
	Assembly_filename_element: STRING is "assembly_filename"
		indexing
			description: "Assembly filename element (in `index.xml')"
			external_name: "AssemblyFilenameElement"
		end

	Assembly_element: STRING is "assembly"
		indexing
			description: "Assembly element in `assembly_description.xml'"
			external_name: "AssemblyElement"
		end
		
	Assembly_name_element: STRING is "assembly_name"
		indexing
			description: "Assembly name element in `assembly_description.xml'"
			external_name: "AssemblyNameElement"
		end
		
	Assembly_version_element: STRING is "assembly_version"
		indexing
			description: "Assembly version element in `assembly_description.xml'"
			external_name: "AssemblyVersionElement"
		end
		
	Assembly_culture_element: STRING is "assembly_culture"
		indexing
			description: "Assembly culture element in `assembly_description.xml'"
			external_name: "AssemblyCultureElement"
		end
		
	Assembly_public_key_element: STRING is "assembly_public_key"
		indexing
			description: "Assembly public key element in `assembly_description.xml'"
			external_name: "AssemblyPublicKeyElement"
		end
	
	Eiffel_cluster_path_element: STRING is "eiffel_cluster_path"
		indexing
			description: "Eiffel cluster path element in `assembly_description.xml'"			
			external_name: "EiffelClusterPathElement"
		end
		
	Emitter_version_number_element: STRING is "emitter_version_number"
		indexing
			description: "Emitter version number element in `assembly_description.xml'"
			external_name: "EmitterVersionNumberElement"
		end
	
	Assembly_types_element: STRING is "assembly_types"
		indexing
			description: "Assembly types element in `assembly_description.xml'"
			external_name: "AssemblyTypesElement"
		end
	
	Assembly_type_filename_element: STRING is "assembly_type_filename"
		indexing
			description: "Assembly type filename element in `assembly_description.xml'"
			external_name: "AssemblyTypeFilenameElement"
		end
		
	Class_element: STRING is "class"
		indexing
			description: "Class element in XML file for a type"
			external_name: "ClassElement"
		end
	
	Header_element: STRING is "header"
		indexing
			description: "Header element in XML file for a type"
			external_name: "HeaderElement"
		end

	Modified_element: STRING is "modified"
		indexing
			description: "Modified element in XML file for a type"
			external_name: "ModifiedElement"
		end	
	
	Frozen_element: STRING is "frozen"
		indexing
			description: "Frozen element in XML file for a type"
			external_name: "FrozenElement"
		end
		
	Expanded_element: STRING is "expanded"
		indexing
			description: "Expanded element in XML file for a type"
			external_name: "ExpandedElement"
		end
		
	Deferred_element: STRING is "deferred"
		indexing
			description: "Deferred element in XML file for a type"
			external_name: "DeferredElement"
		end
		
	Class_eiffel_name_element: STRING is "class_eiffel_name"
		indexing
			description: "Class Eiffel name element in XML file for a type"
			external_name: "ClassEiffelNameElement"
		end
		
	Alias_element: STRING is "alias"
		indexing
			description: "Alias element in XML file for a type"
			external_name: "AliasElement"
		end
		
	Enum_type_element: STRING is "enum_type"
		indexing
			description: "Enum type element in XML file for a type"
			external_name: "EnumTypeElement"
		end
		
	Simple_name_element: STRING is "simple_name"
		indexing
			description: "Simple name element in XML file for a type"
			external_name: "SimpleNameElement"
		end
		
	Namespace_element: STRING is "namespace"
		indexing
			description: "Namespace element in XML file for a type"
			external_name: "NamespaceElement"
		end
		
	Inherit_element: STRING is "inherit"
		indexing
			description: "Inherit element in XML file for a type"
			external_name: "InheritElement"
		end
		
	Parent_element: STRING is "parent"
		indexing
			description: "Parent element in XML file for a type"
			external_name: "ParentElement"
		end
		
	Parent_name_element: STRING is "parent_name"
		indexing
			description: "Parent name element in XML file for a type"
			external_name: "ParentNameElement"
		end
		
	Rename_element: STRING is "rename"
		indexing
			description: "Rename element in XML file for a type"
			external_name: "RenameElement"
		end
		
	Undefine_element: STRING is "undefine"
		indexing
			description: "Undefine element in XML file for a type"
			external_name: "UndefineElement"
		end
		
	Redefine_element: STRING is "redefine"
		indexing
			description: "Redefine element in XML file for a type"
			external_name: "RedefineElement"
		end
		
	Select_element: STRING is "select"
		indexing
			description: "Select element in XML file for a type"
			external_name: "SelectElement"
		end
		
	Export_element: STRING is "export"
		indexing
			description: "Export element in XML file for a type"
			external_name: "ExportElement"
		end
		
	Create_element: STRING is "create"
		indexing
			description: "Create element in XML file for a type"
			external_name: "CreateElement"
		end
		
	Create_none_element: STRING is "create_none"
		indexing
			description: "Create none element in XML file for a type"
			external_name: "CreateNoneElement"
		end
		
	Body_element: STRING is "body"
		indexing
			description: "Body element in XML file for a type"
			external_name: "BodyElement"
		end
		
	Initialization_element: STRING is "initialization"
		indexing
			description: "Initialization element in XML file for a type"
			external_name: "InitializationElement"
		end
		
	Access_element: STRING is "access"
		indexing
			description: "Access element in XML file for a type"
			external_name: "AccessElement"
		end
		
	Element_change_element: STRING is "element_change"
		indexing
			description: "Element change element in XML file for a type"
			external_name: "ElementChangeElement"
		end
		
	Basic_operations_element: STRING is "basic_operations"
		indexing
			description: "Basic operations element in XML file for a type"
			external_name: "BasicOperationsElement"
		end
		
	Unary_operators_element: STRING is "unary_operators"
		indexing
			description: "Unary operators element in XML file for a type"
			external_name: "UnaryOperatorsElement"
		end
		
	Binary_operators_element: STRING is "binary_operators"
		indexing
			description: "Binary operators element in XML file for a type"
			external_name: "BinaryOperatorsElement"
		end
		
	Specials_element: STRING is "specials"
		indexing	
			description: "Specials element in XML file for a type"
			external_name: "SpecialsElement"
		end
		
	Implementation_element: STRING is "implementation"
		indexing
			description: "Implementation element in XML file for a type"
			external_name: "ImplementationElement"
		end
	
	Bit_or_infix_element: STRING is "bit_or_infix"
		indexing
			description: "Bit or infix element in XML file for a type"
			external_name: "BitOrInfixElement"
		end
		
	Feature_element: STRING is "feature"
		indexing
			description: "Feature element in XML file for a type"
			external_name: "FeatureElement"
		end

	Modified_feature_element: STRING is "feature_modified"
		indexing
			description: "Modified feature element in XML file for a type"
			external_name: "ModifiedFeatureElement"
		end
		
	Frozen_feature_element: STRING is "frozen_feature"
		indexing
			description: "Frozen feature element in XML file for a type"
			external_name: "FrozenFeatureElement"
		end
		
	Static_element: STRING is "static"
		indexing
			description: "Static element in XML file for a type"
			external_name: "StaticElement"
		end
		
	Abstract_element: STRING is "abstract"
		indexing
			description: "Abstract element in XML file for a type"
			external_name: "AbstractElement"
		end
		
	Method_element: STRING is "method"
		indexing
			description: "Method element in XML file for a type"
			external_name: "MethodElement"
		end
		
	Field_element: STRING is "field"
		indexing
			description: "Field element in XML file for a type"
			external_name: "FieldElement"
		end
		
	Prefix_element: STRING is "prefix"
		indexing
			description: "Prefix element in XML file for a type"
			external_name: "PrefixElement"
		end
		
	Infix_element: STRING is "infix"
		indexing
			description: "Infix element in XML file for a type"
			external_name: "InfixElement"
		end
		
	Creation_routine_element: STRING is "creation_routine"
		indexing
			description: "Creation routine element in XML file for a type"
			external_name: "CreationRoutineElement"
		end
	
	New_slot_element: STRING is "new_slot"
		indexing
			description: "New slot element in XML file for a type"
			external_name: "NewSlotElement"
		end
		
	Enum_literal_element: STRING is "enum_literal"
		indexing
			description: "Enum literal element in XML file for a type"
			external_name: "EnumLiteralElement"
		end

	Is_literal_element: STRING is "is_literal"
		indexing
			description: "Is literal element in XML file for a type"
			external_name: "IsLiteralElement"
		end
		
	Feature_eiffel_name_element: STRING is "feature_eiffel_name"
		indexing
			description: "Feature Eiffel name element in XML file for a type"			
			external_name: "FeatureEiffelNameElement"
		end
		
	Feature_external_name_element: STRING is "feature_external_name"
		indexing
			description: "Feature external name element in XML file for a type"
			external_name: "FeatureExternalNameElement"
		end
		
	Arguments_element: STRING is "arguments"
		indexing
			description: "Arguments element in XML file for a type"
			external_name: "ArgumentsElement"
		end
		
	Argument_element: STRING is "argument"
		indexing
			description: "Argument element in XML file for a type"
			external_name: "ArgumentElement"
		end
		
	Argument_eiffel_name_element: STRING is "argument_eiffel_name"
		indexing
			description: "Argument Eiffel name element in XML file for a type"
			external_name: "ArgumentEiffelNameElement"
		end
	
	Argument_external_name_element: STRING is "argument_external_name"
		indexing
			description: "Argument external name element in XML file for a type"
			external_name: "ArgumentExternalNameElement"
		end
		
	Argument_type_element: STRING is "argument_type"
		indexing
			description: "Argument type element in XML file for a type (Eiffel name)"
			external_name: "ArgumentTypeElement"
		end
		
	Argument_type_full_name_element: STRING is "argument_type_full_name"
		indexing
			description: "Argument type external full name element in XML file for a type"
			external_name: "ArgumentTypeFullNameElement"
		end
			
	Return_type_element: STRING is "return_type"
		indexing
			description: "Return type element in XML file for a type (Eiffel name)"
			external_name: "ReturnTypeElement"
		end
		
	Return_type_full_name_element: STRING is "return_type_full_name"
		indexing
			description: "Return type external full name element in XML file for a type"
			external_name: "ReturnTypeFullNameElement"
		end
	
	Comments_element: STRING is "comments"
		indexing
			description: "Comments element in XML file for a type"
			external_name: "CommentsElement"
		end
		
	Preconditions_element: STRING is "preconditions"
		indexing
			description: "Preconditions element in XML file for a type"
			external_name: "PreconditionsElement"
		end
		
	Precondition_element: STRING is "precondition"
		indexing
			description: "Precondition element in XML file for a type"
			external_name: "PreconditionElement"
		end
		
	Precondition_tag_element: STRING is "precondition_tag"
		indexing
			description: "Precondition tag element in XML file for a type"
			external_name: "PreconditionTagElement"
		end
		
	Precondition_text_element: STRING is "precondition_text"
		indexing
			description: "Precondition text element in XML file for a type"
			external_name: "PreconditionTextElement"
		end
		
	Postconditions_element: STRING is "postconditions"
		indexing
			description: "Postconditions element in XML file for a type"
			external_name: "PostconditionsElement"
		end
		
	Postcondition_element: STRING is "postcondition"
		indexing
			description: "Postcondition element in XML file for a type"
			external_name: "PostconditionElement"
		end
		
	Postcondition_tag_element: STRING is "postcondition_tag"
		indexing
			description: "Postcondition tag element in XML file for a type"
			external_name: "PostconditionTagElement"
		end
		
	Postcondition_text_element: STRING is "postcondition_text"	
		indexing
			description: "Postcondition text element in XML file for a type"
			external_name: "PostconditionTextElement"
		end
	
	Literal_value_element: STRING is "literal_value"
		indexing
			description: "Literal value element"
			external_name: "LiteralValueElement"
		end
	
	Footer_element: STRING is "footer"
		indexing
			description: "Footer element in XML file for a type"
			external_name: "FooterElement"
		end
		
	Invariants_element: STRING is "invariants"
		indexing
			description: "Invariants element in XML file for a type"
			external_name: "InvariantsElement"
		end
		
	Invariant_element: STRING is "invariant"
		indexing
			description: "Invariant element in XML file for a type"			
			external_name: "InvariantElement"
		end
		
	Invariant_tag_element: STRING is "invariant_tag"
		indexing
			description: "Invariant tag element in XML file for a type"
			external_name: "InvariantTagElement"
		end
		
	Invariant_text_element: STRING is "invariant_text"	
		indexing
			description: "Invariant text element in XML file for a type"
			external_name: "InvariantTextElement"
		end
		
end -- class XML_ELEMENTS