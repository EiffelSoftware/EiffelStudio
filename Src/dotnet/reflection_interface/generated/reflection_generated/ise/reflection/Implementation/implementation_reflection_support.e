indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.REFLECTION_SUPPORT"

external class
	IMPLEMENTATION_REFLECTION_SUPPORT

inherit
	SUPPORT_SUPPORT
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	REFLECTION_SUPPORT
	SUPPORT

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.REFLECTION_SUPPORT"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_error_messages: REFLECTION_SUPPORT_ERROR_MESSAGES is
		external
			"IL field signature :REFLECTION_SUPPORT_ERROR_MESSAGES use Implementation.REFLECTION_SUPPORT"
		alias
			"$$error_messages"
		end

	frozen ec_illegal_36_ec_illegal_36_dictionary: DICTIONARY is
		external
			"IL field signature :DICTIONARY use Implementation.REFLECTION_SUPPORT"
		alias
			"$$dictionary"
		end

	frozen ec_illegal_36_ec_illegal_36_last_error: ERROR_INFO is
		external
			"IL field signature :ERROR_INFO use Implementation.REFLECTION_SUPPORT"
		alias
			"$$last_error"
		end

feature -- Basic Operations

	a_set_error_messages (error_messages2: REFLECTION_SUPPORT_ERROR_MESSAGES) is
		external
			"IL signature (REFLECTION_SUPPORT_ERROR_MESSAGES): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"_set_error_messages"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.REFLECTION_SUPPORT"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.REFLECTION_SUPPORT"
		alias
			"____class_name"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"tagged_out"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_description_filename (current_: REFLECTION_SUPPORT): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"$$assembly_description_filename"
		end

	xml_type_filename (an_assembly_descriptor: ASSEMBLY_DESCRIPTOR; type_full_external_name: STRING): STRING is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR, STRING): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"xml_type_filename"
		end

	frozen ec_illegal_36_ec_illegal_36_clean_assemblies (current_: REFLECTION_SUPPORT) is
		external
			"IL static signature (REFLECTION_SUPPORT): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"$$clean_assemblies"
		end

	assembly_description_filename: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"assembly_description_filename"
		end

	clean_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"clean_assembly"
		end

	from_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"from_component_string"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"generating_type"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"make"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"out"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_folder_path_from_info (current_: REFLECTION_SUPPORT; a_descriptor: ASSEMBLY_DESCRIPTOR): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT, ASSEMBLY_DESCRIPTOR): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"$$assembly_folder_path_from_info"
		end

	default_xml_type_filename: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"default_xml_type_filename"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"internal_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: REFLECTION_SUPPORT) is
		external
			"IL static signature (REFLECTION_SUPPORT): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"$$make"
		end

	create_error_from_info (a_code: INTEGER; a_name: STRING; a_description: STRING) is
		external
			"IL signature (System.Int32, STRING, STRING): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"create_error_from_info"
		end

	assembly_folder_path_from_info (a_descriptor: ASSEMBLY_DESCRIPTOR): STRING is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"assembly_folder_path_from_info"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.REFLECTION_SUPPORT"
		alias
			"conforms_to"
		end

	a_set_dictionary (dictionary2: DICTIONARY) is
		external
			"IL signature (DICTIONARY): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"_set_dictionary"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.REFLECTION_SUPPORT"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_default_xml_type_filename (current_: REFLECTION_SUPPORT): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"$$default_xml_type_filename"
		end

	xml_elements: XML_ELEMENTS is
		external
			"IL signature (): XML_ELEMENTS use Implementation.REFLECTION_SUPPORT"
		alias
			"xml_elements"
		end

	frozen ec_illegal_36_ec_illegal_36_support (current_: REFLECTION_SUPPORT): CODE_GENERATION_SUPPORT is
		external
			"IL static signature (REFLECTION_SUPPORT): CODE_GENERATION_SUPPORT use Implementation.REFLECTION_SUPPORT"
		alias
			"$$support"
		end

	ise_eiffel_key_path: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"ise_eiffel_key_path"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.REFLECTION_SUPPORT"
		alias
			"default"
		end

	dictionary: DICTIONARY is
		external
			"IL signature (): DICTIONARY use Implementation.REFLECTION_SUPPORT"
		alias
			"dictionary"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"do_nothing"
		end

	eiffel_key: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"eiffel_key"
		end

	error_messages: REFLECTION_SUPPORT_ERROR_MESSAGES is
		external
			"IL signature (): REFLECTION_SUPPORT_ERROR_MESSAGES use Implementation.REFLECTION_SUPPORT"
		alias
			"error_messages"
		end

	a_set_last_error (last_error2: ERROR_INFO) is
		external
			"IL signature (ERROR_INFO): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"_set_last_error"
		end

	to_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"to_notifier_string"
		end

	frozen ec_illegal_36_ec_illegal_36_clean_assembly (current_: REFLECTION_SUPPORT; a_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL static signature (REFLECTION_SUPPORT, ASSEMBLY_DESCRIPTOR): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"$$clean_assembly"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.REFLECTION_SUPPORT"
		alias
			"standard_is_equal"
		end

	assemblies_folder_path: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"assemblies_folder_path"
		end

	last_error: ERROR_INFO is
		external
			"IL signature (): ERROR_INFO use Implementation.REFLECTION_SUPPORT"
		alias
			"last_error"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_type_filename (current_: REFLECTION_SUPPORT; an_assembly_descriptor: ASSEMBLY_DESCRIPTOR; type_full_external_name: STRING): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT, ASSEMBLY_DESCRIPTOR, STRING): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"$$xml_type_filename"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.REFLECTION_SUPPORT"
		alias
			"equal"
		end

	create_error (a_name: STRING; a_description: STRING) is
		external
			"IL signature (STRING, STRING): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"create_error"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"default_rescue"
		end

	support: CODE_GENERATION_SUPPORT is
		external
			"IL signature (): CODE_GENERATION_SUPPORT use Implementation.REFLECTION_SUPPORT"
		alias
			"support"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_key (current_: REFLECTION_SUPPORT): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"$$eiffel_key"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.REFLECTION_SUPPORT"
		alias
			"is_equal"
		end

	key: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"key"
		end

	xml_assembly_filename (an_assembly_descriptor: ASSEMBLY_DESCRIPTOR): STRING is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"xml_assembly_filename"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"print"
		end

	to_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"to_component_string"
		end

	frozen ec_illegal_36_ec_illegal_36_ise_eiffel_key_path (current_: REFLECTION_SUPPORT): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"$$ise_eiffel_key_path"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"generator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.REFLECTION_SUPPORT"
		alias
			"ToString"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.REFLECTION_SUPPORT"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.REFLECTION_SUPPORT"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_key (current_: REFLECTION_SUPPORT): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"$$key"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.REFLECTION_SUPPORT"
		alias
			"same_type"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_assemblies_folder_path (current_: REFLECTION_SUPPORT): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"$$assemblies_folder_path"
		end

	eiffel_delivery_path: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"eiffel_delivery_path"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.REFLECTION_SUPPORT"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.REFLECTION_SUPPORT"
		alias
			"GetHashCode"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.REFLECTION_SUPPORT"
		alias
			"deep_equal"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.REFLECTION_SUPPORT"
		alias
			"standard_clone"
		end

	errors_table: ERRORS_TABLE is
		external
			"IL signature (): ERRORS_TABLE use Implementation.REFLECTION_SUPPORT"
		alias
			"errors_table"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.REFLECTION_SUPPORT"
		alias
			"internal_clone"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.REFLECTION_SUPPORT"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_assembly_filename (current_: REFLECTION_SUPPORT; an_assembly_descriptor: ASSEMBLY_DESCRIPTOR): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT, ASSEMBLY_DESCRIPTOR): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"$$xml_assembly_filename"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.REFLECTION_SUPPORT"
		alias
			"default_pointer"
		end

	from_system_string (string: SYSTEM_STRING): STRING is
		external
			"IL signature (System.String): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"from_system_string"
		end

	from_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"from_notifier_string"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_delivery_path (current_: REFLECTION_SUPPORT): STRING is
		external
			"IL static signature (REFLECTION_SUPPORT): STRING use Implementation.REFLECTION_SUPPORT"
		alias
			"$$eiffel_delivery_path"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"deep_copy"
		end

	clean_assemblies is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"clean_assemblies"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_elements (current_: REFLECTION_SUPPORT): XML_ELEMENTS is
		external
			"IL static signature (REFLECTION_SUPPORT): XML_ELEMENTS use Implementation.REFLECTION_SUPPORT"
		alias
			"$$xml_elements"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_SUPPORT"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_REFLECTION_SUPPORT
