indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.EIFFEL_ASSEMBLY_IMP"

external class
	IMPLEMENTATION_EIFFEL_ASSEMBLY_IMP

inherit
	GLOBAL_CONVERSATION_ANY
	SUPPORT_IMP
		rename
			a_set_interface as a_set_support_interface,
			interface as support_interface
		end
	EIFFEL_ASSEMBLY_IMP
		rename
			a_set_interface as a_set_support_interface,
			interface as support_interface
		end
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.EIFFEL_ASSEMBLY_IMP"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_last_error: ERROR_INFO is
		external
			"IL field signature :ERROR_INFO use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"$$last_error"
		end

	frozen ec_illegal_36_ec_illegal_36_support_interface: SUPPORT is
		external
			"IL field signature :SUPPORT use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"$$support_interface"
		end

	frozen ec_illegal_36_ec_illegal_36_class_interface: EIFFEL_ASSEMBLY is
		external
			"IL field signature :EIFFEL_ASSEMBLY use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"$$class_interface"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"deep_clone"
		end

	support_interface: SUPPORT is
		external
			"IL signature (): SUPPORT use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"support_interface"
		end

	frozen ec_illegal_36_ec_illegal_36_types_retrieval_failed (current_: EIFFEL_ASSEMBLY_IMP): SYSTEM_STRING is
		external
			"IL static signature (EIFFEL_ASSEMBLY_IMP): System.String use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"$$types_retrieval_failed"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"tagged_out"
		end

	assembly_descriptor: ASSEMBLY_DESCRIPTOR is
		external
			"IL signature (): ASSEMBLY_DESCRIPTOR use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"assembly_descriptor"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"internal_clone"
		end

	class_interface: EIFFEL_ASSEMBLY is
		external
			"IL signature (): EIFFEL_ASSEMBLY use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"class_interface"
		end

	frozen ec_illegal_36_ec_illegal_36_emitter_version_number (current_: EIFFEL_ASSEMBLY_IMP): SYSTEM_STRING is
		external
			"IL static signature (EIFFEL_ASSEMBLY_IMP): System.String use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"$$emitter_version_number"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"is_equal"
		end

	to_eiffel_linked_list (a_list: ARRAY_LIST): LINKED_LIST_ANY is
		external
			"IL signature (System.Collections.ArrayList): LINKED_LIST_ANY use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"to_eiffel_linked_list"
		end

	from_eiffel_linked_list (a_list: LINKED_LIST_ANY): ARRAY_LIST is
		external
			"IL signature (LINKED_LIST_ANY): System.Collections.ArrayList use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"from_eiffel_linked_list"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_cluster_path (current_: EIFFEL_ASSEMBLY_IMP): SYSTEM_STRING is
		external
			"IL static signature (EIFFEL_ASSEMBLY_IMP): System.String use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"$$eiffel_cluster_path"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"same_type"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"operating_environment"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"internal_copy"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"generator"
		end

	create_error (a_name: SYSTEM_STRING; a_description: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"create_error"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_interface (current_: EIFFEL_ASSEMBLY_IMP; a_interface: EIFFEL_ASSEMBLY) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_IMP, EIFFEL_ASSEMBLY): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"$$make_from_interface"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"equal"
		end

	a_set_class_interface (class_interface2: EIFFEL_ASSEMBLY) is
		external
			"IL signature (EIFFEL_ASSEMBLY): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"_set_class_interface"
		end

	frozen ec_illegal_36_ec_illegal_36_types_retrieval_failed_message (current_: EIFFEL_ASSEMBLY_IMP): SYSTEM_STRING is
		external
			"IL static signature (EIFFEL_ASSEMBLY_IMP): System.String use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"$$types_retrieval_failed_message"
		end

	frozen ec_illegal_36_ec_illegal_36_types (current_: EIFFEL_ASSEMBLY_IMP): ARRAY_LIST is
		external
			"IL static signature (EIFFEL_ASSEMBLY_IMP): System.Collections.ArrayList use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"$$types"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"____class_name"
		end

	types_retrieval_failed_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"types_retrieval_failed_message"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"default_rescue"
		end

	last_error: ERROR_INFO is
		external
			"IL signature (): ERROR_INFO use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"last_error"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"Equals"
		end

	a_set_last_error (last_error2: ERROR_INFO) is
		external
			"IL signature (ERROR_INFO): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"_set_last_error"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_descriptor (current_: EIFFEL_ASSEMBLY_IMP): ASSEMBLY_DESCRIPTOR is
		external
			"IL static signature (EIFFEL_ASSEMBLY_IMP): ASSEMBLY_DESCRIPTOR use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"$$assembly_descriptor"
		end

	types: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"types"
		end

	errors_table: ERRORS_TABLE is
		external
			"IL signature (): ERRORS_TABLE use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"errors_table"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: EIFFEL_ASSEMBLY_IMP; a_descriptor: ASSEMBLY_DESCRIPTOR; a_path: SYSTEM_STRING; a_number: SYSTEM_STRING) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_IMP, ASSEMBLY_DESCRIPTOR, System.String, System.String): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"$$make"
		end

	from_eiffel_string (string: STRING): SYSTEM_STRING is
		external
			"IL signature (STRING): System.String use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"from_eiffel_string"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"io"
		end

	make_from_interface (a_interface: EIFFEL_ASSEMBLY) is
		external
			"IL signature (EIFFEL_ASSEMBLY): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"make_from_interface"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"clone"
		end

	create_error_from_info (a_code: INTEGER; a_name: SYSTEM_STRING; a_description: SYSTEM_STRING) is
		external
			"IL signature (System.Int32, System.String, System.String): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"create_error_from_info"
		end

	eiffel_cluster_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"eiffel_cluster_path"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"conforms_to"
		end

	make (a_descriptor: ASSEMBLY_DESCRIPTOR; a_path: SYSTEM_STRING; a_number: SYSTEM_STRING) is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR, System.String, System.String): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"make"
		end

	types_retrieval_failed: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"types_retrieval_failed"
		end

	to_eiffel_string (string: SYSTEM_STRING): STRING is
		external
			"IL signature (System.String): STRING use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"to_eiffel_string"
		end

	emitter_version_number: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"emitter_version_number"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"print"
		end

	a_set_support_interface (support_interface2: SUPPORT) is
		external
			"IL signature (SUPPORT): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"_set_support_interface"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_IMP"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_EIFFEL_ASSEMBLY_IMP
