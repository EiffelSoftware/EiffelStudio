indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"

external class
	IMPLEMENTATION_REFLECTION_INTERFACE_ERROR_MESSAGES

inherit
	SUPPORT_ERROR_MESSAGES
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	REFLECTION_INTERFACE_ERROR_MESSAGES

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		end

feature -- Basic Operations

	type_retrieval_failed: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"type_retrieval_failed"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"____class_name"
		end

	frozen ec_illegal_36_ec_illegal_36_type_retrieval_failed (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$type_retrieval_failed"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_has_write_lock_message (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$has_write_lock_message"
		end

	frozen ec_illegal_36_ec_illegal_36_invalid_assembly_qualified_name (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$invalid_assembly_qualified_name"
		end

	file_access_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"file_access_failed_message"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"copy"
		end

	registry_key_not_registered_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"registry_key_not_registered_message"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"generating_type"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_no_such_type (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$no_such_type"
		end

	has_read_lock: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"has_read_lock"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"out"
		end

	no_index: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"no_index"
		end

	frozen ec_illegal_36_ec_illegal_36_has_read_lock (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$has_read_lock"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_retrieval_failed (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$assembly_retrieval_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_no_assembly_message (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$no_assembly_message"
		end

	frozen ec_illegal_36_ec_illegal_36_no_such_type_message (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$no_such_type_message"
		end

	frozen ec_illegal_36_ec_illegal_36_registry_key_not_registered_message (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$registry_key_not_registered_message"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"conforms_to"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"io"
		end

	file_access_failed: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"file_access_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_no_assembly (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$no_assembly"
		end

	frozen ec_illegal_36_ec_illegal_36_registry_key_not_registered (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$registry_key_not_registered"
		end

	assembly_retrieval_failed: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"assembly_retrieval_failed"
		end

	no_such_assembly: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"no_such_assembly"
		end

	has_read_lock_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"has_read_lock_message"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"default"
		end

	frozen ec_illegal_36_ec_illegal_36_has_read_lock_message (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$has_read_lock_message"
		end

	frozen ec_illegal_36_ec_illegal_36_has_write_lock (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$has_write_lock"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_removal_failed (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$assembly_removal_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_no_such_assembly_message (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$no_such_assembly_message"
		end

	assembly_removal_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"assembly_removal_failed_message"
		end

	no_assembly: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"no_assembly"
		end

	has_write_lock: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"has_write_lock"
		end

	no_such_assembly_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"no_such_assembly_message"
		end

	type_retrieval_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"type_retrieval_failed_message"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"standard_is_equal"
		end

	no_such_type: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"no_such_type"
		end

	no_such_type_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"no_such_type_message"
		end

	frozen ec_illegal_36_ec_illegal_36_invalid_assembly_qualified_name_message (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$invalid_assembly_qualified_name_message"
		end

	invalid_assembly_qualified_name: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"invalid_assembly_qualified_name"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"default_pointer"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_file_access_failed (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$file_access_failed"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_file_access_failed_message (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$file_access_failed_message"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"standard_copy"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"print"
		end

	no_index_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"no_index_message"
		end

	frozen ec_illegal_36_ec_illegal_36_no_such_assembly (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$no_such_assembly"
		end

	frozen ec_illegal_36_ec_illegal_36_no_index (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$no_index"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_type_retrieval_failed_message (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$type_retrieval_failed_message"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"standard_equal"
		end

	assembly_removal_failed: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"assembly_removal_failed"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"same_type"
		end

	registry_key_not_registered: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"registry_key_not_registered"
		end

	read_lock_creation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"read_lock_creation_failed_message"
		end

	frozen ec_illegal_36_ec_illegal_36_no_index_message (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$no_index_message"
		end

	read_lock_creation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"read_lock_creation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_read_lock_creation_failed_message (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$read_lock_creation_failed_message"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"Equals"
		end

	assembly_retrieval_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"assembly_retrieval_failed_message"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"GetHashCode"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"deep_equal"
		end

	invalid_assembly_qualified_name_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"invalid_assembly_qualified_name_message"
		end

	has_write_lock_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"has_write_lock_message"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_retrieval_failed_message (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$assembly_retrieval_failed_message"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"generator"
		end

	frozen ec_illegal_36_ec_illegal_36_read_lock_creation_failed (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$read_lock_creation_failed"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"internal_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"ToString"
		end

	no_assembly_message: STRING is
		external
			"IL signature (): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"no_assembly_message"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"deep_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_removal_failed_message (current_: REFLECTION_INTERFACE_ERROR_MESSAGES): STRING is
		external
			"IL static signature (REFLECTION_INTERFACE_ERROR_MESSAGES): STRING use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"$$assembly_removal_failed_message"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.REFLECTION_INTERFACE_ERROR_MESSAGES"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_REFLECTION_INTERFACE_ERROR_MESSAGES
