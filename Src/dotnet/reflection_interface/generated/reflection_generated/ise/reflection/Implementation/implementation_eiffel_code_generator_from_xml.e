indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"

external class
	IMPLEMENTATION_EIFFEL_CODE_GENERATOR_FROM_XML

inherit
	EIFFEL_CODE_GENERATOR_FROM_XML
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	CODE_GENERATOR_SUPPORT

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_assembly_description_filename: STRING is
		external
			"IL field signature :STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"$$assembly_description_filename"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_code_generator: EIFFEL_CODE_GENERATOR is
		external
			"IL field signature :EIFFEL_CODE_GENERATOR use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"$$eiffel_code_generator"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_assembly: EIFFEL_ASSEMBLY is
		external
			"IL field signature :EIFFEL_ASSEMBLY use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"$$eiffel_assembly"
		end

feature -- Basic Operations

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_eiffel_code_from_xml (current_: EIFFEL_CODE_GENERATOR_FROM_XML; type_description_filename: STRING) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR_FROM_XML, STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"$$generate_eiffel_code_from_xml"
		end

	eiffel_assembly: EIFFEL_ASSEMBLY is
		external
			"IL signature (): EIFFEL_ASSEMBLY use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"eiffel_assembly"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"operating_environment"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"ToString"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"is_equal"
		end

	generate_eiffel_code_from_xml_and_path (type_description_filename: STRING; a_path: STRING) is
		external
			"IL signature (STRING, STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"generate_eiffel_code_from_xml_and_path"
		end

	from_support_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"from_support_string"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"same_type"
		end

	make_from_info_and_path (an_assembly_description_filename: STRING; new_path: STRING) is
		external
			"IL signature (STRING, STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"make_from_info_and_path"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"generator"
		end

	to_handler_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"to_handler_string"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"internal_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_dotnet_library_relative_path (current_: EIFFEL_CODE_GENERATOR_FROM_XML): STRING is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR_FROM_XML): STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"$$dotnet_library_relative_path"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_info_and_path (current_: EIFFEL_CODE_GENERATOR_FROM_XML; an_assembly_description_filename: STRING; new_path: STRING) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR_FROM_XML, STRING, STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"$$make_from_info_and_path"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"standard_clone"
		end

	eiffel_class_from_xml (type_description_filename: STRING): EIFFEL_CLASS is
		external
			"IL signature (STRING): EIFFEL_CLASS use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"eiffel_class_from_xml"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_class_from_xml (current_: EIFFEL_CODE_GENERATOR_FROM_XML; type_description_filename: STRING): EIFFEL_CLASS is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR_FROM_XML, STRING): EIFFEL_CLASS use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"$$eiffel_class_from_xml"
		end

	a_set_eiffel_code_generator (eiffel_code_generator2: EIFFEL_CODE_GENERATOR) is
		external
			"IL signature (EIFFEL_CODE_GENERATOR): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"_set_eiffel_code_generator"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"default_rescue"
		end

	assembly_description_filename: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"assembly_description_filename"
		end

	to_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"to_component_string"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"standard_copy"
		end

	dotnet_library_relative_path: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"dotnet_library_relative_path"
		end

	from_system_string (string: SYSTEM_STRING): STRING is
		external
			"IL signature (System.String): STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"from_system_string"
		end

	generate_eiffel_code_from_xml (type_description_filename: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"generate_eiffel_code_from_xml"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"default"
		end

	a_set_eiffel_assembly (eiffel_assembly2: EIFFEL_ASSEMBLY) is
		external
			"IL signature (EIFFEL_ASSEMBLY): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"_set_eiffel_assembly"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"deep_equal"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"default_pointer"
		end

	make_from_info (an_assembly_description_filename: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"make_from_info"
		end

	update_assembly_description (new_path: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"update_assembly_description"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_info (current_: EIFFEL_CODE_GENERATOR_FROM_XML; an_assembly_description_filename: STRING) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR_FROM_XML, STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"$$make_from_info"
		end

	frozen ec_illegal_36_ec_illegal_36_generate_eiffel_code_from_xml_and_path (current_: EIFFEL_CODE_GENERATOR_FROM_XML; type_description_filename: STRING; a_path: STRING) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR_FROM_XML, STRING, STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"$$generate_eiffel_code_from_xml_and_path"
		end

	eiffel_code_generator: EIFFEL_CODE_GENERATOR is
		external
			"IL signature (): EIFFEL_CODE_GENERATOR use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"eiffel_code_generator"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"generating_type"
		end

	to_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"to_notifier_string"
		end

	from_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"from_notifier_string"
		end

	frozen ec_illegal_36_ec_illegal_36_update_assembly_description (current_: EIFFEL_CODE_GENERATOR_FROM_XML; new_path: STRING) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR_FROM_XML, STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"$$update_assembly_description"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"io"
		end

	from_handler_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"from_handler_string"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"clone"
		end

	to_support_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"to_support_string"
		end

	a_set_assembly_description_filename (assembly_description_filename2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"_set_assembly_description_filename"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: EIFFEL_CODE_GENERATOR_FROM_XML) is
		external
			"IL static signature (EIFFEL_CODE_GENERATOR_FROM_XML): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"$$make"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"make"
		end

	from_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"from_component_string"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_EIFFEL_CODE_GENERATOR_FROM_XML
