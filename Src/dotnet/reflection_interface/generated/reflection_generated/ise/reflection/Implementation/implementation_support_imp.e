indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.SUPPORT_IMP"

deferred external class
	IMPLEMENTATION_SUPPORT_IMP

inherit
	SUPPORT_IMP
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_interface: SUPPORT is
		external
			"IL field signature :SUPPORT use Implementation.SUPPORT_IMP"
		alias
			"$$interface"
		end

	frozen ec_illegal_36_ec_illegal_36_last_error: ERROR_INFO is
		external
			"IL field signature :ERROR_INFO use Implementation.SUPPORT_IMP"
		alias
			"$$last_error"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.SUPPORT_IMP"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SUPPORT_IMP"
		alias
			"deep_clone"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.SUPPORT_IMP"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.SUPPORT_IMP"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.SUPPORT_IMP"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SUPPORT_IMP"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SUPPORT_IMP"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SUPPORT_IMP"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SUPPORT_IMP"
		alias
			"same_type"
		end

	a_set_interface (interface2: SUPPORT) is
		external
			"IL signature (SUPPORT): System.Void use Implementation.SUPPORT_IMP"
		alias
			"_set_interface"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.SUPPORT_IMP"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SUPPORT_IMP"
		alias
			"internal_copy"
		end

	a_set_last_error (last_error2: ERROR_INFO) is
		external
			"IL signature (ERROR_INFO): System.Void use Implementation.SUPPORT_IMP"
		alias
			"_set_last_error"
		end

	create_error (a_name: SYSTEM_STRING; a_description: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use Implementation.SUPPORT_IMP"
		alias
			"create_error"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SUPPORT_IMP"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SUPPORT_IMP"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_errors_table (current_: SUPPORT_IMP): ERRORS_TABLE is
		external
			"IL static signature (SUPPORT_IMP): ERRORS_TABLE use Implementation.SUPPORT_IMP"
		alias
			"$$errors_table"
		end

	interface: SUPPORT is
		external
			"IL signature (): SUPPORT use Implementation.SUPPORT_IMP"
		alias
			"interface"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SUPPORT_IMP"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.SUPPORT_IMP"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.SUPPORT_IMP"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.SUPPORT_IMP"
		alias
			"default_rescue"
		end

	last_error: ERROR_INFO is
		external
			"IL signature (): ERROR_INFO use Implementation.SUPPORT_IMP"
		alias
			"last_error"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.SUPPORT_IMP"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SUPPORT_IMP"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SUPPORT_IMP"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.SUPPORT_IMP"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SUPPORT_IMP"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.SUPPORT_IMP"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_create_error (current_: SUPPORT_IMP; a_name: SYSTEM_STRING; a_description: SYSTEM_STRING) is
		external
			"IL static signature (SUPPORT_IMP, System.String, System.String): System.Void use Implementation.SUPPORT_IMP"
		alias
			"$$create_error"
		end

	errors_table: ERRORS_TABLE is
		external
			"IL signature (): ERRORS_TABLE use Implementation.SUPPORT_IMP"
		alias
			"errors_table"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.SUPPORT_IMP"
		alias
			"generating_type"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.SUPPORT_IMP"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.SUPPORT_IMP"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SUPPORT_IMP"
		alias
			"clone"
		end

	create_error_from_info (a_code: INTEGER; a_name: SYSTEM_STRING; a_description: SYSTEM_STRING) is
		external
			"IL signature (System.Int32, System.String, System.String): System.Void use Implementation.SUPPORT_IMP"
		alias
			"create_error_from_info"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SUPPORT_IMP"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SUPPORT_IMP"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SUPPORT_IMP"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_create_error_from_info (current_: SUPPORT_IMP; a_code: INTEGER; a_name: SYSTEM_STRING; a_description: SYSTEM_STRING) is
		external
			"IL static signature (SUPPORT_IMP, System.Int32, System.String, System.String): System.Void use Implementation.SUPPORT_IMP"
		alias
			"$$create_error_from_info"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SUPPORT_IMP"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.SUPPORT_IMP"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_SUPPORT_IMP
