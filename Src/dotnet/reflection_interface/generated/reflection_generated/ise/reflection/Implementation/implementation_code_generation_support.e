indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.CODE_GENERATION_SUPPORT"

external class
	IMPLEMENTATION_CODE_GENERATION_SUPPORT

inherit
	CODE_GENERATION_SUPPORT
	SUPPORT_SUPPORT
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SUPPORT

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.CODE_GENERATION_SUPPORT"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_type_description: SYSTEM_XML_XML_TEXT_READER is
		external
			"IL field signature :System.Xml.XmlTextReader use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$type_description"
		end

	frozen ec_illegal_36_ec_illegal_36_generic_type_names: ARRAY_ANY is
		external
			"IL field signature :ARRAY_ANY use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$generic_type_names"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_elements: XML_ELEMENTS is
		external
			"IL field signature :XML_ELEMENTS use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$xml_elements"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_class: EIFFEL_CLASS is
		external
			"IL field signature :EIFFEL_CLASS use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$eiffel_class"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_feature: EIFFEL_FEATURE is
		external
			"IL field signature :EIFFEL_FEATURE use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$eiffel_feature"
		end

	frozen ec_illegal_36_ec_illegal_36_error_messages: CODE_GENERATION_SUPPORT_ERROR_MESSAGES is
		external
			"IL field signature :CODE_GENERATION_SUPPORT_ERROR_MESSAGES use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$error_messages"
		end

	frozen ec_illegal_36_ec_illegal_36_last_error: ERROR_INFO is
		external
			"IL field signature :ERROR_INFO use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$last_error"
		end

feature -- Basic Operations

	a_set_error_messages (error_messages2: CODE_GENERATION_SUPPORT_ERROR_MESSAGES) is
		external
			"IL signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"_set_error_messages"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"operating_environment"
		end

	type_description: SYSTEM_XML_XML_TEXT_READER is
		external
			"IL signature (): System.Xml.XmlTextReader use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"type_description"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"____class_name"
		end

	generate_class_body is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"generate_class_body"
		end

	generate_feature_assertions (element_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"generate_feature_assertions"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"default_create"
		end

	generic_type_names: ARRAY_ANY is
		external
			"IL signature (): ARRAY_ANY use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"generic_type_names"
		end

	frozen ec_illegal_36_ec_illegal_36_generic_name_base (current_: CODE_GENERATION_SUPPORT): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT): STRING use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$generic_name_base"
		end

	set_feature_info is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"set_feature_info"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_arguments (current_: CODE_GENERATION_SUPPORT) is
		external
			"IL static signature (CODE_GENERATION_SUPPORT): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$generate_arguments"
		end

	from_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"from_component_string"
		end

	has_write_lock (a_folder_name: STRING): BOOLEAN is
		external
			"IL signature (STRING): System.Boolean use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"has_write_lock"
		end

	frozen ec_illegal_36_ec_illegal_36_read_lock_filename (current_: CODE_GENERATION_SUPPORT): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT): STRING use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$read_lock_filename"
		end

	eiffel_class_from_xml (a_filename: STRING): EIFFEL_CLASS is
		external
			"IL signature (STRING): EIFFEL_CLASS use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"eiffel_class_from_xml"
		end

	eiffel_feature: EIFFEL_FEATURE is
		external
			"IL signature (): EIFFEL_FEATURE use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"eiffel_feature"
		end

	a_set_generic_type_names (generic_type_names2: ARRAY_ANY) is
		external
			"IL signature (ARRAY_ANY): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"_set_generic_type_names"
		end

	frozen ec_illegal_36_ec_illegal_36_is_valid_filename (current_: CODE_GENERATION_SUPPORT; a_filename: STRING): BOOLEAN is
		external
			"IL static signature (CODE_GENERATION_SUPPORT, STRING): System.Boolean use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$is_valid_filename"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"copy"
		end

	eiffel_assembly_from_xml (a_filename: STRING): EIFFEL_ASSEMBLY is
		external
			"IL signature (STRING): EIFFEL_ASSEMBLY use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"eiffel_assembly_from_xml"
		end

	frozen ec_illegal_36_ec_illegal_36_create_folder (current_: CODE_GENERATION_SUPPORT; a_path: STRING) is
		external
			"IL static signature (CODE_GENERATION_SUPPORT, STRING): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$create_folder"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"generating_type"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"make"
		end

	generate_parents is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"generate_parents"
		end

	a_set_type_description (type_description2: SYSTEM_XML_XML_TEXT_READER) is
		external
			"IL signature (System.Xml.XmlTextReader): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"_set_type_description"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"out"
		end

	eiffel_class: EIFFEL_CLASS is
		external
			"IL signature (): EIFFEL_CLASS use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"eiffel_class"
		end

	generate_class_footer is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"generate_class_footer"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_class_footer (current_: CODE_GENERATION_SUPPORT) is
		external
			"IL static signature (CODE_GENERATION_SUPPORT): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$generate_class_footer"
		end

	frozen ec_illegal_36_ec_illegal_36_has_read_lock (current_: CODE_GENERATION_SUPPORT; a_folder_name: STRING): BOOLEAN is
		external
			"IL static signature (CODE_GENERATION_SUPPORT, STRING): System.Boolean use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$has_read_lock"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: CODE_GENERATION_SUPPORT) is
		external
			"IL static signature (CODE_GENERATION_SUPPORT): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$make"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"default_rescue"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_comments (current_: CODE_GENERATION_SUPPORT) is
		external
			"IL static signature (CODE_GENERATION_SUPPORT): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$generate_comments"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_generic_derivations (current_: CODE_GENERATION_SUPPORT) is
		external
			"IL static signature (CODE_GENERATION_SUPPORT): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$generate_generic_derivations"
		end

	create_error_from_info (a_code: INTEGER; a_name: STRING; a_description: STRING) is
		external
			"IL signature (System.Int32, STRING, STRING): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"create_error_from_info"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"conforms_to"
		end

	is_valid_filename (a_filename: STRING): BOOLEAN is
		external
			"IL signature (STRING): System.Boolean use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"is_valid_filename"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"io"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_class_body (current_: CODE_GENERATION_SUPPORT) is
		external
			"IL static signature (CODE_GENERATION_SUPPORT): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$generate_class_body"
		end

	generate_features (element_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"generate_features"
		end

	xml_elements: XML_ELEMENTS is
		external
			"IL signature (): XML_ELEMENTS use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"xml_elements"
		end

	write_lock_filename: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"write_lock_filename"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_class_from_xml (current_: CODE_GENERATION_SUPPORT; a_filename: STRING): EIFFEL_CLASS is
		external
			"IL static signature (CODE_GENERATION_SUPPORT, STRING): EIFFEL_CLASS use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$eiffel_class_from_xml"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_set_feature_info (current_: CODE_GENERATION_SUPPORT) is
		external
			"IL static signature (CODE_GENERATION_SUPPORT): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$set_feature_info"
		end

	generic_name_base: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"generic_name_base"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"default"
		end

	frozen ec_illegal_36_ec_illegal_36_is_valid_directory_path (current_: CODE_GENERATION_SUPPORT; a_path: STRING): BOOLEAN is
		external
			"IL static signature (CODE_GENERATION_SUPPORT, STRING): System.Boolean use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$is_valid_directory_path"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"same_type"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"do_nothing"
		end

	error_messages: CODE_GENERATION_SUPPORT_ERROR_MESSAGES is
		external
			"IL signature (): CODE_GENERATION_SUPPORT_ERROR_MESSAGES use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"error_messages"
		end

	frozen ec_illegal_36_ec_illegal_36_has_write_lock (current_: CODE_GENERATION_SUPPORT; a_folder_name: STRING): BOOLEAN is
		external
			"IL static signature (CODE_GENERATION_SUPPORT, STRING): System.Boolean use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$has_write_lock"
		end

	a_set_last_error (last_error2: ERROR_INFO) is
		external
			"IL signature (ERROR_INFO): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"_set_last_error"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"deep_equal"
		end

	to_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"to_notifier_string"
		end

	is_valid_directory_path (a_path: STRING): BOOLEAN is
		external
			"IL signature (STRING): System.Boolean use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"is_valid_directory_path"
		end

	generate_arguments is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"generate_arguments"
		end

	generate_class_header is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"generate_class_header"
		end

	generate_comments is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"generate_comments"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_class_header (current_: CODE_GENERATION_SUPPORT) is
		external
			"IL static signature (CODE_GENERATION_SUPPORT): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$generate_class_header"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"standard_is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_feature_assertions (current_: CODE_GENERATION_SUPPORT; element_name: STRING) is
		external
			"IL static signature (CODE_GENERATION_SUPPORT, STRING): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$generate_feature_assertions"
		end

	last_error: ERROR_INFO is
		external
			"IL signature (): ERROR_INFO use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"last_error"
		end

	create_error (a_name: STRING; a_description: STRING) is
		external
			"IL signature (STRING, STRING): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"create_error"
		end

	has_read_lock (a_folder_name: STRING): BOOLEAN is
		external
			"IL signature (STRING): System.Boolean use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"has_read_lock"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_features (current_: CODE_GENERATION_SUPPORT; element_name: STRING) is
		external
			"IL static signature (CODE_GENERATION_SUPPORT, STRING): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$generate_features"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"is_equal"
		end

	a_set_eiffel_class (eiffel_class2: EIFFEL_CLASS) is
		external
			"IL signature (EIFFEL_CLASS): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"_set_eiffel_class"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"print"
		end

	frozen ec_illegal_36_ec_illegal_36_generic_names_table (current_: CODE_GENERATION_SUPPORT): ARRAY_ANY is
		external
			"IL static signature (CODE_GENERATION_SUPPORT): ARRAY_ANY use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$generic_names_table"
		end

	create_folder (a_path: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"create_folder"
		end

	to_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"to_component_string"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"equal"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"ToString"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"standard_equal"
		end

	read_lock_filename: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"read_lock_filename"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_parents (current_: CODE_GENERATION_SUPPORT) is
		external
			"IL static signature (CODE_GENERATION_SUPPORT): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$generate_parents"
		end

	a_set_eiffel_feature (eiffel_feature2: EIFFEL_FEATURE) is
		external
			"IL signature (EIFFEL_FEATURE): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"_set_eiffel_feature"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_assembly_from_xml (current_: CODE_GENERATION_SUPPORT; a_filename: STRING): EIFFEL_ASSEMBLY is
		external
			"IL static signature (CODE_GENERATION_SUPPORT, STRING): EIFFEL_ASSEMBLY use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$eiffel_assembly_from_xml"
		end

	a_set_xml_elements (xml_elements2: XML_ELEMENTS) is
		external
			"IL signature (XML_ELEMENTS): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"_set_xml_elements"
		end

	frozen ec_illegal_36_ec_illegal_36_write_lock_filename (current_: CODE_GENERATION_SUPPORT): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT): STRING use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$write_lock_filename"
		end

	generate_generic_derivations is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"generate_generic_derivations"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"Equals"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"standard_clone"
		end

	generic_names_table: ARRAY_ANY is
		external
			"IL signature (): ARRAY_ANY use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"generic_names_table"
		end

	errors_table: ERRORS_TABLE is
		external
			"IL signature (): ERRORS_TABLE use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"errors_table"
		end

	compute_generic_names (a_count: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"compute_generic_names"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_compute_generic_names (current_: CODE_GENERATION_SUPPORT; a_count: INTEGER) is
		external
			"IL static signature (CODE_GENERATION_SUPPORT, System.Int32): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"$$compute_generic_names"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"internal_copy"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"default_pointer"
		end

	from_system_string (string: SYSTEM_STRING): STRING is
		external
			"IL signature (System.String): STRING use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"from_system_string"
		end

	from_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"from_notifier_string"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"deep_copy"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_CODE_GENERATION_SUPPORT
