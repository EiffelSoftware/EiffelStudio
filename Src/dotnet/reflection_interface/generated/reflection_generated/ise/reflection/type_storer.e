indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "TYPE_STORER"

deferred external class
	TYPE_STORER

inherit
	EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT
	XML_ELEMENTS
	DICTIONARY

feature -- Basic Operations

	error_messages: TYPE_STORER_ERROR_MESSAGES is
		external
			"IL deferred signature (): TYPE_STORER_ERROR_MESSAGES use TYPE_STORER"
		alias
			"error_messages"
		end

	generate_xml_class_header is
		external
			"IL deferred signature (): System.Void use TYPE_STORER"
		alias
			"generate_xml_class_header"
		end

	generate_generic_derivations is
		external
			"IL deferred signature (): System.Void use TYPE_STORER"
		alias
			"generate_generic_derivations"
		end

	string_from_inheritance_clauses (a_list: LINKED_LIST_ANY): STRING is
		external
			"IL deferred signature (LINKED_LIST_ANY): STRING use TYPE_STORER"
		alias
			"string_from_inheritance_clauses"
		end

	make_type_storer (a_folder_name: STRING) is
		external
			"IL deferred signature (STRING): System.Void use TYPE_STORER"
		alias
			"make_type_storer"
		end

	commit is
		external
			"IL deferred signature (): System.Void use TYPE_STORER"
		alias
			"commit"
		end

	generate_xml_class_footer (invariants: LINKED_LIST_ANY) is
		external
			"IL deferred signature (LINKED_LIST_ANY): System.Void use TYPE_STORER"
		alias
			"generate_xml_class_footer"
		end

	committed: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use TYPE_STORER"
		alias
			"committed"
		end

	exists (a_filename: STRING): BOOLEAN is
		external
			"IL deferred signature (STRING): System.Boolean use TYPE_STORER"
		alias
			"exists"
		end

	generate_xml_feature_element (a_feature: EIFFEL_FEATURE) is
		external
			"IL deferred signature (EIFFEL_FEATURE): System.Void use TYPE_STORER"
		alias
			"generate_xml_feature_element"
		end

	a_set_text_writer (text_writer2: SYSTEM_XML_XML_TEXT_WRITER) is
		external
			"IL deferred signature (System.Xml.XmlTextWriter): System.Void use TYPE_STORER"
		alias
			"_set_text_writer"
		end

	a_set_last_error (last_error2: ERROR_INFO) is
		external
			"IL deferred signature (ERROR_INFO): System.Void use TYPE_STORER"
		alias
			"_set_last_error"
		end

	eiffel_class: EIFFEL_CLASS is
		external
			"IL deferred signature (): EIFFEL_CLASS use TYPE_STORER"
		alias
			"eiffel_class"
		end

	generate_xml_class_body is
		external
			"IL deferred signature (): System.Void use TYPE_STORER"
		alias
			"generate_xml_class_body"
		end

	generate_xml_features_element (features: LINKED_LIST_ANY) is
		external
			"IL deferred signature (LINKED_LIST_ANY): System.Void use TYPE_STORER"
		alias
			"generate_xml_features_element"
		end

	generate_xml_elements_from_assertions (assertions: LINKED_LIST_ANY; assertion_type: STRING) is
		external
			"IL deferred signature (LINKED_LIST_ANY, STRING): System.Void use TYPE_STORER"
		alias
			"generate_xml_elements_from_assertions"
		end

	a_set_eiffel_class (eiffel_class2: EIFFEL_CLASS) is
		external
			"IL deferred signature (EIFFEL_CLASS): System.Void use TYPE_STORER"
		alias
			"_set_eiffel_class"
		end

	assembly_description_filename: STRING is
		external
			"IL deferred signature (): STRING use TYPE_STORER"
		alias
			"assembly_description_filename"
		end

	a_set_parents (parents2: HASH_TABLE_ANY_ANY) is
		external
			"IL deferred signature (HASH_TABLE_ANY_ANY): System.Void use TYPE_STORER"
		alias
			"_set_parents"
		end

	generate_xml_element_from_inheritance_clauses (xml_element: STRING; a_list: LINKED_LIST_ANY) is
		external
			"IL deferred signature (STRING, LINKED_LIST_ANY): System.Void use TYPE_STORER"
		alias
			"generate_xml_element_from_inheritance_clauses"
		end

	generate_xml_elements_from_feature_arguments (arguments: LINKED_LIST_ANY) is
		external
			"IL deferred signature (LINKED_LIST_ANY): System.Void use TYPE_STORER"
		alias
			"generate_xml_elements_from_feature_arguments"
		end

	add_type (an_eiffel_class: EIFFEL_CLASS; overwrite: BOOLEAN) is
		external
			"IL deferred signature (EIFFEL_CLASS, System.Boolean): System.Void use TYPE_STORER"
		alias
			"add_type"
		end

	update_assembly_description is
		external
			"IL deferred signature (): System.Void use TYPE_STORER"
		alias
			"update_assembly_description"
		end

	a_set_error_messages (error_messages2: TYPE_STORER_ERROR_MESSAGES) is
		external
			"IL deferred signature (TYPE_STORER_ERROR_MESSAGES): System.Void use TYPE_STORER"
		alias
			"_set_error_messages"
		end

	support: CODE_GENERATION_SUPPORT is
		external
			"IL deferred signature (): CODE_GENERATION_SUPPORT use TYPE_STORER"
		alias
			"support"
		end

	types: LINKED_LIST_ANY is
		external
			"IL deferred signature (): LINKED_LIST_ANY use TYPE_STORER"
		alias
			"types"
		end

	a_set_committed (committed2: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use TYPE_STORER"
		alias
			"_set_committed"
		end

	generate_xml_element_from_list (xml_element: STRING; a_list: LINKED_LIST_ANY) is
		external
			"IL deferred signature (STRING, LINKED_LIST_ANY): System.Void use TYPE_STORER"
		alias
			"generate_xml_element_from_list"
		end

	string_from_list (a_list: LINKED_LIST_ANY): STRING is
		external
			"IL deferred signature (LINKED_LIST_ANY): STRING use TYPE_STORER"
		alias
			"string_from_list"
		end

	assembly_folder_name: STRING is
		external
			"IL deferred signature (): STRING use TYPE_STORER"
		alias
			"assembly_folder_name"
		end

	is_valid_directory_path (a_folder_name: STRING): BOOLEAN is
		external
			"IL deferred signature (STRING): System.Boolean use TYPE_STORER"
		alias
			"is_valid_directory_path"
		end

	a_set_types (types2: LINKED_LIST_ANY) is
		external
			"IL deferred signature (LINKED_LIST_ANY): System.Void use TYPE_STORER"
		alias
			"_set_types"
		end

	a_set_assembly_folder_name (assembly_folder_name2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use TYPE_STORER"
		alias
			"_set_assembly_folder_name"
		end

	last_error: ERROR_INFO is
		external
			"IL deferred signature (): ERROR_INFO use TYPE_STORER"
		alias
			"last_error"
		end

	generate_xml_alias_element is
		external
			"IL deferred signature (): System.Void use TYPE_STORER"
		alias
			"generate_xml_alias_element"
		end

	text_writer: SYSTEM_XML_XML_TEXT_WRITER is
		external
			"IL deferred signature (): System.Xml.XmlTextWriter use TYPE_STORER"
		alias
			"text_writer"
		end

	parents: HASH_TABLE_ANY_ANY is
		external
			"IL deferred signature (): HASH_TABLE_ANY_ANY use TYPE_STORER"
		alias
			"parents"
		end

	generate_xml_inherit_element is
		external
			"IL deferred signature (): System.Void use TYPE_STORER"
		alias
			"generate_xml_inherit_element"
		end

end -- class TYPE_STORER
