indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CODE_GENERATION_SUPPORT"

deferred external class
	CODE_GENERATION_SUPPORT

inherit
	SUPPORT_SUPPORT
	SUPPORT

feature -- Basic Operations

	xml_elements: XML_ELEMENTS is
		external
			"IL deferred signature (): XML_ELEMENTS use CODE_GENERATION_SUPPORT"
		alias
			"xml_elements"
		end

	compute_generic_names (a_count: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"compute_generic_names"
		end

	a_set_eiffel_feature (eiffel_feature2: EIFFEL_FEATURE) is
		external
			"IL deferred signature (EIFFEL_FEATURE): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"_set_eiffel_feature"
		end

	write_lock_filename: STRING is
		external
			"IL deferred signature (): STRING use CODE_GENERATION_SUPPORT"
		alias
			"write_lock_filename"
		end

	generate_generic_derivations is
		external
			"IL deferred signature (): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"generate_generic_derivations"
		end

	a_set_xml_elements (xml_elements2: XML_ELEMENTS) is
		external
			"IL deferred signature (XML_ELEMENTS): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"_set_xml_elements"
		end

	eiffel_class: EIFFEL_CLASS is
		external
			"IL deferred signature (): EIFFEL_CLASS use CODE_GENERATION_SUPPORT"
		alias
			"eiffel_class"
		end

	generate_feature_assertions (element_name: STRING) is
		external
			"IL deferred signature (STRING): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"generate_feature_assertions"
		end

	generate_arguments is
		external
			"IL deferred signature (): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"generate_arguments"
		end

	a_set_generic_type_names (generic_type_names2: ARRAY_ANY) is
		external
			"IL deferred signature (ARRAY_ANY): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"_set_generic_type_names"
		end

	has_read_lock (a_folder_name: STRING): BOOLEAN is
		external
			"IL deferred signature (STRING): System.Boolean use CODE_GENERATION_SUPPORT"
		alias
			"has_read_lock"
		end

	set_feature_info is
		external
			"IL deferred signature (): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"set_feature_info"
		end

	eiffel_feature: EIFFEL_FEATURE is
		external
			"IL deferred signature (): EIFFEL_FEATURE use CODE_GENERATION_SUPPORT"
		alias
			"eiffel_feature"
		end

	generic_names_table: ARRAY_ANY is
		external
			"IL deferred signature (): ARRAY_ANY use CODE_GENERATION_SUPPORT"
		alias
			"generic_names_table"
		end

	generate_class_body is
		external
			"IL deferred signature (): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"generate_class_body"
		end

	type_description: SYSTEM_XML_XML_TEXT_READER is
		external
			"IL deferred signature (): System.Xml.XmlTextReader use CODE_GENERATION_SUPPORT"
		alias
			"type_description"
		end

	a_set_type_description (type_description2: SYSTEM_XML_XML_TEXT_READER) is
		external
			"IL deferred signature (System.Xml.XmlTextReader): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"_set_type_description"
		end

	has_write_lock (a_folder_name: STRING): BOOLEAN is
		external
			"IL deferred signature (STRING): System.Boolean use CODE_GENERATION_SUPPORT"
		alias
			"has_write_lock"
		end

	generate_comments is
		external
			"IL deferred signature (): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"generate_comments"
		end

	a_set_eiffel_class (eiffel_class2: EIFFEL_CLASS) is
		external
			"IL deferred signature (EIFFEL_CLASS): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"_set_eiffel_class"
		end

	a_set_error_messages (error_messages2: CODE_GENERATION_SUPPORT_ERROR_MESSAGES) is
		external
			"IL deferred signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"_set_error_messages"
		end

	generate_class_header is
		external
			"IL deferred signature (): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"generate_class_header"
		end

	generate_class_footer is
		external
			"IL deferred signature (): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"generate_class_footer"
		end

	generate_features (element_name: STRING) is
		external
			"IL deferred signature (STRING): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"generate_features"
		end

	generate_parents is
		external
			"IL deferred signature (): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"generate_parents"
		end

	is_valid_directory_path (a_path: STRING): BOOLEAN is
		external
			"IL deferred signature (STRING): System.Boolean use CODE_GENERATION_SUPPORT"
		alias
			"is_valid_directory_path"
		end

	generic_name_base: STRING is
		external
			"IL deferred signature (): STRING use CODE_GENERATION_SUPPORT"
		alias
			"generic_name_base"
		end

	is_valid_filename (a_filename: STRING): BOOLEAN is
		external
			"IL deferred signature (STRING): System.Boolean use CODE_GENERATION_SUPPORT"
		alias
			"is_valid_filename"
		end

	eiffel_class_from_xml (a_filename: STRING): EIFFEL_CLASS is
		external
			"IL deferred signature (STRING): EIFFEL_CLASS use CODE_GENERATION_SUPPORT"
		alias
			"eiffel_class_from_xml"
		end

	generic_type_names: ARRAY_ANY is
		external
			"IL deferred signature (): ARRAY_ANY use CODE_GENERATION_SUPPORT"
		alias
			"generic_type_names"
		end

	error_messages: CODE_GENERATION_SUPPORT_ERROR_MESSAGES is
		external
			"IL deferred signature (): CODE_GENERATION_SUPPORT_ERROR_MESSAGES use CODE_GENERATION_SUPPORT"
		alias
			"error_messages"
		end

	eiffel_assembly_from_xml (a_filename: STRING): EIFFEL_ASSEMBLY is
		external
			"IL deferred signature (STRING): EIFFEL_ASSEMBLY use CODE_GENERATION_SUPPORT"
		alias
			"eiffel_assembly_from_xml"
		end

	read_lock_filename: STRING is
		external
			"IL deferred signature (): STRING use CODE_GENERATION_SUPPORT"
		alias
			"read_lock_filename"
		end

	make is
		external
			"IL deferred signature (): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"make"
		end

	create_folder (a_path: STRING) is
		external
			"IL deferred signature (STRING): System.Void use CODE_GENERATION_SUPPORT"
		alias
			"create_folder"
		end

end -- class CODE_GENERATION_SUPPORT
