indexing
	Generator: "Eiffel Emitter 2.6b2"
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

	frozen text_writer: SYSTEM_XML_XMLTEXTWRITER is
		external
			"IL field signature :System.Xml.XmlTextWriter use ISE.Reflection.TypeStorer"
		alias
			"TextWriter"
		end

	frozen committed: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.TypeStorer"
		alias
			"Committed"
		end

	frozen eiffel_class: ISE_REFLECTION_EIFFELCLASS is
		external
			"IL field signature :ISE.Reflection.EiffelClass use ISE.Reflection.TypeStorer"
		alias
			"EiffelClass"
		end

	frozen assembly_folder_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.TypeStorer"
		alias
			"AssemblyFolderName"
		end

	frozen error_messages: ISE_REFLECTION_TYPESTORERERRORMESSAGES is
		external
			"IL field signature :ISE.Reflection.TypeStorerErrorMessages use ISE.Reflection.TypeStorer"
		alias
			"ErrorMessages"
		end

	frozen parents: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.TypeStorer"
		alias
			"Parents"
		end

	frozen last_error: ISE_REFLECTION_ERRORINFO is
		external
			"IL field signature :ISE.Reflection.ErrorInfo use ISE.Reflection.TypeStorer"
		alias
			"last_error"
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

	generate_xml_class_footer (invariants: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlClassFooter"
		end

	generate_xml_class_header is
		external
			"IL signature (): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlClassHeader"
		end

end -- class ISE_REFLECTION_TYPESTORER
