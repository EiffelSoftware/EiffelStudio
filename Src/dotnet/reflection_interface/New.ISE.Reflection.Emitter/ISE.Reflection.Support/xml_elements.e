indexing
	description: "XML elements names for assembly and type decription xml files"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	XML_ELEMENTS

inherit
	DICTIONARY

		
feature -- Access
		
	Assemblies_element: STRING is "assemblies"
		indexing
			description: "Assemblies element in `index.xml'"
		end
			
	Assembly_filename_element: STRING is "assembly_filename"
		indexing
			description: "Assembly filename element (in `index.xml')"
		end

	Assembly_element: STRING is "assembly"
		indexing
			description: "Assembly element in `assembly_description.xml'"
		end
		
	Assembly_name_element: STRING is "assembly_name"
		indexing
			description: "Assembly name element in `assembly_description.xml'"
		end
		
	Assembly_version_element: STRING is "assembly_version"
		indexing
			description: "Assembly version element in `assembly_description.xml'"
		end
		
	Assembly_culture_element: STRING is "assembly_culture"
		indexing
			description: "Assembly culture element in `assembly_description.xml'"
		end
		
	Assembly_public_key_element: STRING is "assembly_public_key"
		indexing
			description: "Assembly public key element in `assembly_description.xml'"
		end
	
	Eiffel_cluster_path_element: STRING is "eiffel_cluster_path"
		indexing
			description: "Eiffel cluster path element in `assembly_description.xml'"			
		end
		
	Emitter_version_number_element: STRING is "emitter_version_number"
		indexing
			description: "Emitter version number element in `assembly_description.xml'"
		end
	
	Assembly_types_element: STRING is "assembly_types"
		indexing
			description: "Assembly types element in `assembly_description.xml'"
		end
	
	Assembly_type_filename_element: STRING is "assembly_type_filename"
		indexing
			description: "Assembly type filename element in `assembly_description.xml'"
		end
		
	Class_element: STRING is "class"
		indexing
			description: "Class element in XML file for a type"
		end
	
	Header_element: STRING is "header"
		indexing
			description: "Header element in XML file for a type"
		end

	Modified_element: STRING is "modified"
		indexing
			description: "Modified element in XML file for a type"
		end	
	
	Frozen_element: STRING is "frozen"
		indexing
			description: "Frozen element in XML file for a type"
		end
		
	Expanded_element: STRING is "expanded"
		indexing
			description: "Expanded element in XML file for a type"
		end
		
	Deferred_element: STRING is "deferred"
		indexing
			description: "Deferred element in XML file for a type"
		end

	Generic_element: STRING is "generic"
		indexing
			description: "Generic element in XML file for a type"
		end

	Generic_derivations_element: STRING is "generic_derivations"
		indexing
			description: "Generic derivations element in XML file for a type"
		end

	Generic_derivation_element: STRING is "generic_derivation"
		indexing
			description: "Generic derivation element in XML file for a type"
		end

	Derivation_types_count_element: STRING is "derivation_types_count"
		indexing
			description: "Derivation types count element in XML file for a type"
		end

	Generic_type_element: STRING is "generic_type"
		indexing
			description: "Generic type element in XML file for a type"
		end

	Generic_type_eiffel_name_element: STRING is "generic_type_eiffel_name"
		indexing
			description: "Generic type eiffel name element in XML file for a type"
		end

	Generic_type_external_name_element: STRING is "generic_type_external_name"
		indexing
			description: "Generic type external name element in XML file for a type"
		end

	Constraints_element: STRING is "constraints"
		indexing
			description: "Constraints element in XML file for a type"
		end
		
	Constraint_element: STRING is "constraint"
		indexing
			description: "Constraint element in XML file for a type"
		end
		
	Class_eiffel_name_element: STRING is "class_eiffel_name"
		indexing
			description: "Class Eiffel name element in XML file for a type"
		end
		
	Alias_element: STRING is "alias"
		indexing
			description: "Alias element in XML file for a type"
		end
		
	Enum_type_element: STRING is "enum_type"
		indexing
			description: "Enum type element in XML file for a type"
		end
		
	Simple_name_element: STRING is "simple_name"
		indexing
			description: "Simple name element in XML file for a type"
		end
		
	Namespace_element: STRING is "namespace"
		indexing
			description: "Namespace element in XML file for a type"
		end
		
	Inherit_element: STRING is "inherit"
		indexing
			description: "Inherit element in XML file for a type"
		end
		
	Parent_element: STRING is "parent"
		indexing
			description: "Parent element in XML file for a type"
		end
		
	Parent_name_element: STRING is "parent_name"
		indexing
			description: "Parent name element in XML file for a type"
		end
		
	Rename_element: STRING is "rename"
		indexing
			description: "Rename element in XML file for a type"
		end
		
	Undefine_element: STRING is "undefine"
		indexing
			description: "Undefine element in XML file for a type"
		end
		
	Redefine_element: STRING is "redefine"
		indexing
			description: "Redefine element in XML file for a type"
		end
		
	Select_element: STRING is "select"
		indexing
			description: "Select element in XML file for a type"
		end
		
	Export_element: STRING is "export"
		indexing
			description: "Export element in XML file for a type"
		end
		
	Create_element: STRING is "create"
		indexing
			description: "Create element in XML file for a type"
		end
		
	Create_none_element: STRING is "create_none"
		indexing
			description: "Create none element in XML file for a type"
		end
		
	Body_element: STRING is "body"
		indexing
			description: "Body element in XML file for a type"
		end
		
	Initialization_element: STRING is "initialization"
		indexing
			description: "Initialization element in XML file for a type"
		end
		
	Access_element: STRING is "access"
		indexing
			description: "Access element in XML file for a type"
		end
		
	Element_change_element: STRING is "element_change"
		indexing
			description: "Element change element in XML file for a type"
		end
		
	Basic_operations_element: STRING is "basic_operations"
		indexing
			description: "Basic operations element in XML file for a type"
		end
		
	Unary_operators_element: STRING is "unary_operators"
		indexing
			description: "Unary operators element in XML file for a type"
		end
		
	Binary_operators_element: STRING is "binary_operators"
		indexing
			description: "Binary operators element in XML file for a type"
		end
		
	Specials_element: STRING is "specials"
		indexing	
			description: "Specials element in XML file for a type"
		end
		
	Implementation_element: STRING is "implementation"
		indexing
			description: "Implementation element in XML file for a type"
		end
	
	Bit_or_infix_element: STRING is "bit_or_infix"
		indexing
			description: "Bit or infix element in XML file for a type"
		end
		
	Feature_element: STRING is "feature"
		indexing
			description: "Feature element in XML file for a type"
		end

	Modified_feature_element: STRING is "feature_modified"
		indexing
			description: "Modified feature element in XML file for a type"
		end
		
	Frozen_feature_element: STRING is "frozen_feature"
		indexing
			description: "Frozen feature element in XML file for a type"
		end
		
	Static_element: STRING is "static"
		indexing
			description: "Static element in XML file for a type"
		end
		
	Abstract_element: STRING is "abstract"
		indexing
			description: "Abstract element in XML file for a type"
		end
		
	Method_element: STRING is "method"
		indexing
			description: "Method element in XML file for a type"
		end
		
	Field_element: STRING is "field"
		indexing
			description: "Field element in XML file for a type"
		end
		
	Prefix_element: STRING is "prefix"
		indexing
			description: "Prefix element in XML file for a type"
		end
		
	Infix_element: STRING is "infix"
		indexing
			description: "Infix element in XML file for a type"
		end
		
	Creation_routine_element: STRING is "creation_routine"
		indexing
			description: "Creation routine element in XML file for a type"
		end
	
	New_slot_element: STRING is "new_slot"
		indexing
			description: "New slot element in XML file for a type"
		end
		
	Enum_literal_element: STRING is "enum_literal"
		indexing
			description: "Enum literal element in XML file for a type"
		end

	Is_literal_element: STRING is "is_literal"
		indexing
			description: "Is literal element in XML file for a type"
		end
		
	Feature_eiffel_name_element: STRING is "feature_eiffel_name"
		indexing
			description: "Feature Eiffel name element in XML file for a type"			
		end
		
	Feature_external_name_element: STRING is "feature_external_name"
		indexing
			description: "Feature external name element in XML file for a type"
		end
		
	Arguments_element: STRING is "arguments"
		indexing
			description: "Arguments element in XML file for a type"
		end
		
	Argument_element: STRING is "argument"
		indexing
			description: "Argument element in XML file for a type"
		end
		
	Argument_eiffel_name_element: STRING is "argument_eiffel_name"
		indexing
			description: "Argument Eiffel name element in XML file for a type"
		end
	
	Argument_external_name_element: STRING is "argument_external_name"
		indexing
			description: "Argument external name element in XML file for a type"
		end
		
	Argument_type_element: STRING is "argument_type"
		indexing
			description: "Argument type element in XML file for a type (Eiffel name)"
		end
		
	Argument_type_full_name_element: STRING is "argument_type_full_name"
		indexing
			description: "Argument type external full name element in XML file for a type"
		end

	Generic_parameter_index_element: STRING is "generic_parameter_index"
		indexing
			description: "Generic parameter index element in XML file for a type"
		end
		
	Return_type_element: STRING is "return_type"
		indexing
			description: "Return type element in XML file for a type (Eiffel name)"
		end
		
	Return_type_full_name_element: STRING is "return_type_full_name"
		indexing
			description: "Return type external full name element in XML file for a type"
		end

	Return_type_generic_parameter_index_element: STRING is "return_type_generic_parameter_index"
		indexing
			description: "Return type generic parameter index element in XML file for a type (in case it is a generic return type)"
		end
		
	Comments_element: STRING is "comments"
		indexing
			description: "Comments element in XML file for a type"
		end
		
	Preconditions_element: STRING is "preconditions"
		indexing
			description: "Preconditions element in XML file for a type"
		end
		
	Precondition_element: STRING is "precondition"
		indexing
			description: "Precondition element in XML file for a type"
		end
		
	Precondition_tag_element: STRING is "precondition_tag"
		indexing
			description: "Precondition tag element in XML file for a type"
		end
		
	Precondition_text_element: STRING is "precondition_text"
		indexing
			description: "Precondition text element in XML file for a type"
		end
		
	Postconditions_element: STRING is "postconditions"
		indexing
			description: "Postconditions element in XML file for a type"
		end
		
	Postcondition_element: STRING is "postcondition"
		indexing
			description: "Postcondition element in XML file for a type"
		end
		
	Postcondition_tag_element: STRING is "postcondition_tag"
		indexing
			description: "Postcondition tag element in XML file for a type"
		end
		
	Postcondition_text_element: STRING is "postcondition_text"	
		indexing
			description: "Postcondition text element in XML file for a type"
		end
	
	Literal_value_element: STRING is "literal_value"
		indexing
			description: "Literal value element"
		end
	
	Footer_element: STRING is "footer"
		indexing
			description: "Footer element in XML file for a type"
		end
		
	Invariants_element: STRING is "invariants"
		indexing
			description: "Invariants element in XML file for a type"
		end
		
	Invariant_element: STRING is "invariant"
		indexing
			description: "Invariant element in XML file for a type"			
		end
		
	Invariant_tag_element: STRING is "invariant_tag"
		indexing
			description: "Invariant tag element in XML file for a type"
		end
		
	Invariant_text_element: STRING is "invariant_text"	
		indexing
			description: "Invariant text element in XML file for a type"
		end
		
end -- class XML_ELEMENTS
