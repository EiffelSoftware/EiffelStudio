indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "ISE.Reflection.TypeStorer"

external class
	ISE_REFLECTION_TYPESTORER

inherit
	ISE_REFLECTION_XMLELEMENTS

create
	make_typestorer

feature {NONE} -- Initialization

	frozen make_typestorer is
		external
			"IL creator use ISE.Reflection.TypeStorer"
		end

feature -- Access

	frozen a_internal_types: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.TypeStorer"
		alias
			"_internal_Types"
		end

	frozen a_internal_error_messages: ISE_REFLECTION_TYPESTORERERRORMESSAGES is
		external
			"IL field signature :ISE.Reflection.TypeStorerErrorMessages use ISE.Reflection.TypeStorer"
		alias
			"_internal_ErrorMessages"
		end

	get_types: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.TypeStorer"
		alias
			"get_Types"
		end

	get_last_error: ISE_REFLECTION_ERRORINFO is
		external
			"IL signature (): ISE.Reflection.ErrorInfo use ISE.Reflection.TypeStorer"
		alias
			"get_last_error"
		end

	frozen a_internal_committed: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.TypeStorer"
		alias
			"_internal_Committed"
		end

	frozen a_internal_text_writer: SYSTEM_XML_XMLTEXTWRITER is
		external
			"IL field signature :System.Xml.XmlTextWriter use ISE.Reflection.TypeStorer"
		alias
			"_internal_TextWriter"
		end

	get_assembly_folder_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.TypeStorer"
		alias
			"get_AssemblyFolderName"
		end

	frozen a_internal_last_error: ISE_REFLECTION_ERRORINFO is
		external
			"IL field signature :ISE.Reflection.ErrorInfo use ISE.Reflection.TypeStorer"
		alias
			"_internal_last_error"
		end

	frozen a_internal_parents: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.TypeStorer"
		alias
			"_internal_Parents"
		end

	get_text_writer: SYSTEM_XML_XMLTEXTWRITER is
		external
			"IL signature (): System.Xml.XmlTextWriter use ISE.Reflection.TypeStorer"
		alias
			"get_TextWriter"
		end

	frozen a_internal_assembly_folder_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.TypeStorer"
		alias
			"_internal_AssemblyFolderName"
		end

	get_parents: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL signature (): System.Collections.Hashtable use ISE.Reflection.TypeStorer"
		alias
			"get_Parents"
		end

	frozen a_internal_eiffel_class: ISE_REFLECTION_EIFFELCLASS is
		external
			"IL field signature :ISE.Reflection.EiffelClass use ISE.Reflection.TypeStorer"
		alias
			"_internal_EiffelClass"
		end

	get_eiffel_class: ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (): ISE.Reflection.EiffelClass use ISE.Reflection.TypeStorer"
		alias
			"get_EiffelClass"
		end

	get_error_messages: ISE_REFLECTION_TYPESTORERERRORMESSAGES is
		external
			"IL signature (): ISE.Reflection.TypeStorerErrorMessages use ISE.Reflection.TypeStorer"
		alias
			"get_ErrorMessages"
		end

	get_committed: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.TypeStorer"
		alias
			"get_Committed"
		end

feature -- Basic Operations

	commit is
		external
			"IL signature (): System.Void use ISE.Reflection.TypeStorer"
		alias
			"Commit"
		end

	generate_xml_element_from_list (xml_element: STRING; a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.String, System.Collections.ArrayList): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlElementFromList"
		end

	string_from_list (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): STRING is
		external
			"IL signature (System.Collections.ArrayList): System.String use ISE.Reflection.TypeStorer"
		alias
			"StringFromList"
		end

	generate_xml_feature_element (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlFeatureElement"
		end

	exists (a_filename: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use ISE.Reflection.TypeStorer"
		alias
			"Exists"
		end

	generate_xml_features_element (features: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlFeaturesElement"
		end

	generate_xml_elements_from_feature_arguments (arguments: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlElementsFromFeatureArguments"
		end

	generate_xml_inherit_element is
		external
			"IL signature (): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlInheritElement"
		end

	generate_xml_element_from_inheritance_clauses (xml_element: STRING; a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.String, System.Collections.ArrayList): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlElementFromInheritanceClauses"
		end

	support: ISE_REFLECTION_CODEGENERATIONSUPPORT is
		external
			"IL signature (): ISE.Reflection.CodeGenerationSupport use ISE.Reflection.TypeStorer"
		alias
			"Support"
		end

	string_from_inheritance_clauses (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): STRING is
		external
			"IL signature (System.Collections.ArrayList): System.String use ISE.Reflection.TypeStorer"
		alias
			"StringFromInheritanceClauses"
		end

	add_type (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS; overwrite: BOOLEAN) is
		external
			"IL signature (ISE.Reflection.EiffelClass, System.Boolean): System.Void use ISE.Reflection.TypeStorer"
		alias
			"AddType"
		end

	make_type_storer (a_folder_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.TypeStorer"
		alias
			"MakeTypeStorer"
		end

	generate_xml_alias_element is
		external
			"IL signature (): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlAliasElement"
		end

	generate_xml_class_body is
		external
			"IL signature (): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlClassBody"
		end

	generate_xml_elements_from_assertions (assertions: SYSTEM_COLLECTIONS_ARRAYLIST; assertion_type: STRING) is
		external
			"IL signature (System.Collections.ArrayList, System.String): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlElementsFromAssertions"
		end

	assembly_description_filename: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.TypeStorer"
		alias
			"AssemblyDescriptionFilename"
		end

	generate_xml_class_footer (invariants: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlClassFooter"
		end

	update_assembly_description is
		external
			"IL signature (): System.Void use ISE.Reflection.TypeStorer"
		alias
			"UpdateAssemblyDescription"
		end

	generate_xml_class_header is
		external
			"IL signature (): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlClassHeader"
		end

end -- class ISE_REFLECTION_TYPESTORER
