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
			-- Assemblies element in `index.xml'
		indexing
			external_name: "AssembliesElement"
		end
			
	Assembly_filename_element: STRING is "assembly_filename"
			-- Assembly filename element (in `index.xml')
		indexing
			external_name: "AssemblyFilenameElement"
		end

	Assembly_element: STRING is "assembly"
		indexing
			external_name: "AssemblyElement"
		end
		
	Assembly_name_element: STRING is "assembly_name"
		indexing
			external_name: "AssemblyNameElement"
		end
		
	Assembly_version_element: STRING is "assembly_version"
		indexing
			external_name: "AssemblyVersionElement"
		end
		
	Assembly_culture_element: STRING is "assembly_culture"
		indexing
			external_name: "AssemblyCultureElement"
		end
		
	Assembly_public_key_element: STRING is "assembly_public_key"
		indexing
			external_name: "AssemblyPublicKeyElement"
		end
	
	Eiffel_cluster_path_element: STRING is "eiffel_cluster_path"
		indexing
			external_name: "EiffelClusterPathElement"
		end
		
	Emitter_version_number_element: STRING is "emitter_version_number"
		indexing
			external_name: "EmitterVersionNumberElement"
		end
	
	Assembly_types_element: STRING is "assembly_types"
		indexing
			external_name: "AssemblyTypesElement"
		end
	
	Assembly_type_filename_element: STRING is "assembly_type_filename"
		indexing
			external_name: "AssemblyTypeFilenameElement"
		end
		
	Class_element: STRING is "class"
		indexing
			external_name: "ClassElement"
		end
	
	Header_element: STRING is "header"
		indexing
			external_name: "HeaderElement"
		end
		
	Frozen_element: STRING is "frozen"
		indexing
			external_name: "FrozenElement"
		end
		
	Expanded_element: STRING is "expanded"
		indexing
			external_name: "ExpandedElement"
		end
		
	Deferred_element: STRING is "deferred"
		indexing
			external_name: "DeferredElement"
		end
		
	Class_eiffel_name_element: STRING is "class_eiffel_name"
		indexing
			external_name: "ClassEiffelNameElement"
		end
		
	Alias_element: STRING is "alias"
		indexing
			external_name: "AliasElement"
		end
		
	Simple_name_element: STRING is "simple_name"
		indexing
			external_name: "SimpleNameElement"
		end
		
	Namespace_element: STRING is "namespace"
		indexing
			external_name: "NamespaceElement"
		end
		
	Inherit_element: STRING is "inherit"
		indexing
			external_name: "InheritElement"
		end
		
	Parent_element: STRING is "parent"
		indexing
			external_name: "ParentElement"
		end
		
	Parent_name_element: STRING is "parent_name"
		indexing
			external_name: "ParentNameElement"
		end
		
	Rename_element: STRING is "rename"
		indexing
			external_name: "RenameElement"
		end
		
	Undefine_element: STRING is "undefine"
		indexing
			external_name: "UndefineElement"
		end
		
	Redefine_element: STRING is "redefine"
		indexing
			external_name: "RedefineElement"
		end
		
	Select_element: STRING is "select"
		indexing
			external_name: "SelectElement"
		end
		
	Export_element: STRING is "export"
		indexing
			external_name: "ExportElement"
		end
		
	Create_element: STRING is "create"
		indexing
			external_name: "CreateElement"
		end
		
	Create_none_element: STRING is "create_none"
		indexing
			external_name: "CreateNoneElement"
		end
		
	Body_element: STRING is "body"
		indexing
			external_name: "BodyElement"
		end
		
	Initialization_element: STRING is "initialization"
		indexing
			external_name: "InitializationElement"
		end
		
	Access_element: STRING is "access"
		indexing
			external_name: "AccessElement"
		end
		
	Element_change_element: STRING is "element_change"
		indexing
			external_name: "ElementChangeElement"
		end
		
	Basic_operations_element: STRING is "basic_operations"
		indexing
			external_name: "BasicOperationsElement"
		end
		
	Unary_operators_element: STRING is "unary_operators"
		indexing
			external_name: "UnaryOperatorsElement"
		end
		
	Binary_operators_element: STRING is "binary_operators"
		indexing
			external_name: "BinaryOperatorsElement"
		end
		
	Specials_element: STRING is "specials"
		indexing
			external_name: "SpecialsElement"
		end
		
	Implementation_element: STRING is "implementation"
		indexing
			external_name: "ImplementationElement"
		end
		
	Feature_element: STRING is "feature"
		indexing
			external_name: "FeatureElement"
		end
		
	Frozen_feature_element: STRING is "frozen_feature"
		indexing
			external_name: "FrozenFeatureElement"
		end
		
	Static_element: STRING is "static"
		indexing
			external_name: "StaticElement"
		end
		
	Abstract_element: STRING is "abstract"
		indexing
			external_name: "AbstractElement"
		end
		
	Method_element: STRING is "method"
		indexing
			external_name: "MethodElement"
		end
		
	Field_element: STRING is "field"
		indexing
			external_name: "FieldElement"
		end
		
	Prefix_element: STRING is "prefix"
		indexing
			external_name: "PrefixElement"
		end
		
	Infix_element: STRING is "infix"
		indexing
			external_name: "InfixElement"
		end
		
	Creation_routine_element: STRING is "creation_routine"
		indexing
			external_name: "CreationRoutineElement"
		end
		
	Feature_eiffel_name_element: STRING is "feature_eiffel_name"
		indexing
			external_name: "FeatureEiffelNameElement"
		end
		
	Feature_external_name_element: STRING is "feature_external_name"
		indexing
			external_name: "FeatureExternalNameElement"
		end
		
	Arguments_element: STRING is "arguments"
		indexing
			external_name: "ArgumentsElement"
		end
		
	Argument_element: STRING is "argument"
		indexing
			external_name: "ArgumentElement"
		end
		
	Argument_eiffel_name_element: STRING is "argument_eiffel_name"
		indexing
			external_name: "ArgumentEiffelNameElement"
		end
	
	Argument_external_name_element: STRING is "argument_external_name"
		indexing
			external_name: "ArgumentExternalNameElement"
		end
		
	Argument_type_element: STRING is "argument_type"
		indexing
			external_name: "ArgumentTypeElement"
		end
		
	Argument_type_full_name_element: STRING is "argument_type_full_name"
		indexing
			external_name: "ArgumentTypeFullNameElement"
		end
	
	Argument_type_enum_element: STRING is "argument_type_enum"
		indexing
			external_name: "ArgumentTypeEnumElement"
		end
		
	Return_type_element: STRING is "return_type"
		indexing
			external_name: "ReturnTypeElement"
		end
		
	Return_type_full_name_element: STRING is "return_type_full_name"
		indexing
			external_name: "ReturnTypeFullNameElement"
		end
	
	Return_type_enum_element: STRING is "return_type_enum"
		indexing
			external_name: "ReturnTypeEnumElement"
		end
		
	Comments_element: STRING is "comments"
		indexing
			external_name: "CommentsElement"
		end
		
	Preconditions_element: STRING is "preconditions"
		indexing
			external_name: "PreconditionsElement"
		end
		
	Precondition_element: STRING is "precondition"
		indexing
			external_name: "PreconditionElement"
		end
		
	Precondition_tag_element: STRING is "precondition_tag"
		indexing
			external_name: "PreconditionTagElement"
		end
		
	Precondition_text_element: STRING is "precondition_text"
		indexing
			external_name: "PreconditionTextElement"
		end
		
	Postconditions_element: STRING is "postconditions"
		indexing
			external_name: "PostconditionsElement"
		end
		
	Postcondition_element: STRING is "postcondition"
		indexing
			external_name: "PostconditionElement"
		end
		
	Postcondition_tag_element: STRING is "postcondition_tag"
		indexing
			external_name: "PostconditionTagElement"
		end
		
	Postcondition_text_element: STRING is "postcondition_text"	
		indexing
			external_name: "PostconditionTextElement"
		end
	
	Footer_element: STRING is "footer"
		indexing
			external_name: "FooterElement"
		end
		
	Invariants_element: STRING is "invariants"
		indexing
			external_name: "InvariantsElement"
		end
		
	Invariant_element: STRING is "invariant"
		indexing
			external_name: "InvariantElement"
		end
		
	Invariant_tag_element: STRING is "invariant_tag"
		indexing
			external_name: "InvariantTagElement"
		end
		
	Invariant_text_element: STRING is "invariant_text"	
		indexing
			external_name: "InvariantTextElement"
		end
		
end -- class XML_ELEMENTS