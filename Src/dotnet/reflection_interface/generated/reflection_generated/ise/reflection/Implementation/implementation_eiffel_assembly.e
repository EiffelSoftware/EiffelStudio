indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.EIFFEL_ASSEMBLY"

external class
	IMPLEMENTATION_EIFFEL_ASSEMBLY

inherit
	SUPPORT_SUPPORT
	EIFFEL_ASSEMBLY
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
			"IL creator use Implementation.EIFFEL_ASSEMBLY"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_eiffel_cluster_path: STRING is
		external
			"IL field signature :STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"$$eiffel_cluster_path"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_elements: XML_ELEMENTS is
		external
			"IL field signature :XML_ELEMENTS use Implementation.EIFFEL_ASSEMBLY"
		alias
			"$$xml_elements"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_descriptor: ASSEMBLY_DESCRIPTOR is
		external
			"IL field signature :ASSEMBLY_DESCRIPTOR use Implementation.EIFFEL_ASSEMBLY"
		alias
			"$$assembly_descriptor"
		end

	frozen ec_illegal_36_ec_illegal_36_implementation: EIFFEL_ASSEMBLY_IMP is
		external
			"IL field signature :EIFFEL_ASSEMBLY_IMP use Implementation.EIFFEL_ASSEMBLY"
		alias
			"$$implementation"
		end

	frozen ec_illegal_36_ec_illegal_36_last_error: ERROR_INFO is
		external
			"IL field signature :ERROR_INFO use Implementation.EIFFEL_ASSEMBLY"
		alias
			"$$last_error"
		end

	frozen ec_illegal_36_ec_illegal_36_emitter_version_number: STRING is
		external
			"IL field signature :STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"$$emitter_version_number"
		end

feature -- Basic Operations

	xml_elements: XML_ELEMENTS is
		external
			"IL signature (): XML_ELEMENTS use Implementation.EIFFEL_ASSEMBLY"
		alias
			"xml_elements"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_ASSEMBLY"
		alias
			"standard_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.EIFFEL_ASSEMBLY"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_ASSEMBLY"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_types_retrieval_failed (current_: EIFFEL_ASSEMBLY): STRING is
		external
			"IL static signature (EIFFEL_ASSEMBLY): STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"$$types_retrieval_failed"
		end

	a_set_implementation (implementation2: EIFFEL_ASSEMBLY_IMP) is
		external
			"IL signature (EIFFEL_ASSEMBLY_IMP): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"_set_implementation"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_ASSEMBLY"
		alias
			"ToString"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"tagged_out"
		end

	assembly_descriptor: ASSEMBLY_DESCRIPTOR is
		external
			"IL signature (): ASSEMBLY_DESCRIPTOR use Implementation.EIFFEL_ASSEMBLY"
		alias
			"assembly_descriptor"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.EIFFEL_ASSEMBLY"
		alias
			"internal_clone"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY"
		alias
			"is_equal"
		end

	set_implementation (a_implementation: EIFFEL_ASSEMBLY_IMP) is
		external
			"IL signature (EIFFEL_ASSEMBLY_IMP): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"set_implementation"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY"
		alias
			"same_type"
		end

	a_set_xml_elements (xml_elements2: XML_ELEMENTS) is
		external
			"IL signature (XML_ELEMENTS): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"_set_xml_elements"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.EIFFEL_ASSEMBLY"
		alias
			"operating_environment"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"internal_copy"
		end

	a_set_last_error (last_error2: ERROR_INFO) is
		external
			"IL signature (ERROR_INFO): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"_set_last_error"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.EIFFEL_ASSEMBLY"
		alias
			"Equals"
		end

	create_error (a_name: STRING; a_description: STRING) is
		external
			"IL signature (STRING, STRING): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"create_error"
		end

	a_set_eiffel_cluster_path (eiffel_cluster_path2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"_set_eiffel_cluster_path"
		end

	make_from_implementation (a_implementation: EIFFEL_ASSEMBLY_IMP; a_descriptor: ASSEMBLY_DESCRIPTOR; a_path: STRING; a_number: STRING) is
		external
			"IL signature (EIFFEL_ASSEMBLY_IMP, ASSEMBLY_DESCRIPTOR, STRING, STRING): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"make_from_implementation"
		end

	emitter_version_number: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"emitter_version_number"
		end

	from_system_string (string: SYSTEM_STRING): STRING is
		external
			"IL signature (System.String): STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"from_system_string"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_types_retrieval_failed_message (current_: EIFFEL_ASSEMBLY): STRING is
		external
			"IL static signature (EIFFEL_ASSEMBLY): STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"$$types_retrieval_failed_message"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_ASSEMBLY"
		alias
			"____class_name"
		end

	types_retrieval_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"types_retrieval_failed_message"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"default_rescue"
		end

	last_error: ERROR_INFO is
		external
			"IL signature (): ERROR_INFO use Implementation.EIFFEL_ASSEMBLY"
		alias
			"last_error"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.EIFFEL_ASSEMBLY"
		alias
			"default_pointer"
		end

	to_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"to_component_string"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"standard_copy"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.EIFFEL_ASSEMBLY"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY"
		alias
			"deep_equal"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"generator"
		end

	frozen ec_illegal_36_ec_illegal_36_set_implementation (current_: EIFFEL_ASSEMBLY; a_implementation: EIFFEL_ASSEMBLY_IMP) is
		external
			"IL static signature (EIFFEL_ASSEMBLY, EIFFEL_ASSEMBLY_IMP): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"$$set_implementation"
		end

	types: LINKED_LIST_ANY is
		external
			"IL signature (): LINKED_LIST_ANY use Implementation.EIFFEL_ASSEMBLY"
		alias
			"types"
		end

	implementation: EIFFEL_ASSEMBLY_IMP is
		external
			"IL signature (): EIFFEL_ASSEMBLY_IMP use Implementation.EIFFEL_ASSEMBLY"
		alias
			"implementation"
		end

	a_set_emitter_version_number (emitter_version_number2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"_set_emitter_version_number"
		end

	errors_table: ERRORS_TABLE is
		external
			"IL signature (): ERRORS_TABLE use Implementation.EIFFEL_ASSEMBLY"
		alias
			"errors_table"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_types (current_: EIFFEL_ASSEMBLY): LINKED_LIST_ANY is
		external
			"IL static signature (EIFFEL_ASSEMBLY): LINKED_LIST_ANY use Implementation.EIFFEL_ASSEMBLY"
		alias
			"$$types"
		end

	to_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"to_notifier_string"
		end

	from_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"from_notifier_string"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.EIFFEL_ASSEMBLY"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_ASSEMBLY"
		alias
			"clone"
		end

	create_error_from_info (a_code: INTEGER; a_name: STRING; a_description: STRING) is
		external
			"IL signature (System.Int32, STRING, STRING): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"create_error_from_info"
		end

	a_set_assembly_descriptor (assembly_descriptor2: ASSEMBLY_DESCRIPTOR) is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"_set_assembly_descriptor"
		end

	eiffel_cluster_path: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"eiffel_cluster_path"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_implementation (current_: EIFFEL_ASSEMBLY; a_implementation: EIFFEL_ASSEMBLY_IMP; a_descriptor: ASSEMBLY_DESCRIPTOR; a_path: STRING; a_number: STRING) is
		external
			"IL static signature (EIFFEL_ASSEMBLY, EIFFEL_ASSEMBLY_IMP, ASSEMBLY_DESCRIPTOR, STRING, STRING): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"$$make_from_implementation"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: EIFFEL_ASSEMBLY; a_descriptor: ASSEMBLY_DESCRIPTOR; a_path: STRING; a_number: STRING) is
		external
			"IL static signature (EIFFEL_ASSEMBLY, ASSEMBLY_DESCRIPTOR, STRING, STRING): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"$$make"
		end

	types_retrieval_failed: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"types_retrieval_failed"
		end

	make (a_descriptor: ASSEMBLY_DESCRIPTOR; a_path: STRING; a_number: STRING) is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR, STRING, STRING): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"make"
		end

	from_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.EIFFEL_ASSEMBLY"
		alias
			"from_component_string"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_EIFFEL_ASSEMBLY
