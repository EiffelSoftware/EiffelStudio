indexing
	description: "XML elements for file `assembly_modifications.xml'"
	external_name: "ISE.AssemblyManager.AssemblyModificationsXmlElements"

class
	ASSEMBLY_MODIFICATIONS_XML_ELEMENTS

feature -- Access

	Modified_assembly_element: STRING is "modified_assembly"
		indexing
			external_name: "ModifiedAssemblyElement"
		end
	
	Assembly_descriptor_element: STRING is "assembly_descriptor"
		indexing
			external_name: "AssemblyDescriptorElement"
		end
	
	Assembly_name_element: STRING is "assembly_name"
		indexing
			external_name: "AssemblyNameElement"
		end
	
	Assembly_version_element: STRING is "assembly_version"
		indexing
			external_name: "AssemblyVersionElement"
		end	

	Assembly_culture_element: STRING is "assemby_culture"
		indexing
			external_name: "AssemblyCultureElement"
		end

	Assembly_public_key_element: STRING is "assembly_public_key"
		indexing
			external_name: "AssemblyPublicKeyElement"
		end

	Modifications_element: STRING is "modifications_element"
		indexing
			external_name: "ModificationsElement"
		end
	
	Type_element: STRING is "type"
		indexing
			external_name: "Type"
		end
	
	Class_name_element: STRING is "class_name"
		indexing
			external_name: "ClassNameElement"
		end
	
	Dot_net_full_name_element: STRING is "dot_net_full_name"
		indexing
			external_name: "DotNetFullNameElement"
		end
	
	New_class_name_element: STRING is "new_class_name"
		indexing
			external_name: "NewClassNameElement"
		end
	
	Features_element: STRING is "features"
		indexing
			external_name: "FeaturesElement"
		end

	Feature_element: STRING is "feature"
		indexing
			external_name: "FeatureElement"
		end
		
	New_feature_name_element: STRING is "new_feature_name"
		indexing
			external_name: "NewFeatureNameElement"
		end

	Feature_external_name_element: STRING is "feature_external_name"
		indexing
			external_name: "FeatureExternalNameElement"
		end
	
	Is_field_element: STRING is "is_field"
		indexing
			external_name: "IsField"
		end
		
	Arguments_element: STRING is "arguments"
		indexing
			external_name: "ArgumentsElement"
		end
	
	Argument_type_external_name_element: STRING is "argument_type_external_name"
		indexing
			external_name: "ArgumentTypeExternalNameElement"
		end
		
end -- class ASSEMBLY_MODIFICATIONS_XML_ELEMENTS
