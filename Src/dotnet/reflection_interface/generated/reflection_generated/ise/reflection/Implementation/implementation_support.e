indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.SUPPORT"

deferred external class
	IMPLEMENTATION_SUPPORT

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SUPPORT

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_last_error: ERROR_INFO is
		external
			"IL field signature :ERROR_INFO use Implementation.SUPPORT"
		alias
			"$$last_error"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.SUPPORT"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SUPPORT"
		alias
			"deep_clone"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SUPPORT"
		alias
			"ToString"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.SUPPORT"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.SUPPORT"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.SUPPORT"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SUPPORT"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SUPPORT"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SUPPORT"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SUPPORT"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.SUPPORT"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SUPPORT"
		alias
			"internal_copy"
		end

	a_set_last_error (last_error2: ERROR_INFO) is
		external
			"IL signature (ERROR_INFO): System.Void use Implementation.SUPPORT"
		alias
			"_set_last_error"
		end

	create_error (a_name: STRING; a_description: STRING) is
		external
			"IL signature (STRING, STRING): System.Void use Implementation.SUPPORT"
		alias
			"create_error"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SUPPORT"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SUPPORT"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_errors_table (current_: SUPPORT): ERRORS_TABLE is
		external
			"IL static signature (SUPPORT): ERRORS_TABLE use Implementation.SUPPORT"
		alias
			"$$errors_table"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SUPPORT"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.SUPPORT"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.SUPPORT"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.SUPPORT"
		alias
			"default_rescue"
		end

	last_error: ERROR_INFO is
		external
			"IL signature (): ERROR_INFO use Implementation.SUPPORT"
		alias
			"last_error"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.SUPPORT"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SUPPORT"
		alias
			"standard_copy"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.SUPPORT"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SUPPORT"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.SUPPORT"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_create_error (current_: SUPPORT; a_name: STRING; a_description: STRING) is
		external
			"IL static signature (SUPPORT, STRING, STRING): System.Void use Implementation.SUPPORT"
		alias
			"$$create_error"
		end

	errors_table: ERRORS_TABLE is
		external
			"IL signature (): ERRORS_TABLE use Implementation.SUPPORT"
		alias
			"errors_table"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.SUPPORT"
		alias
			"generating_type"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.SUPPORT"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.SUPPORT"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SUPPORT"
		alias
			"clone"
		end

	create_error_from_info (a_code: INTEGER; a_name: STRING; a_description: STRING) is
		external
			"IL signature (System.Int32, STRING, STRING): System.Void use Implementation.SUPPORT"
		alias
			"create_error_from_info"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SUPPORT"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SUPPORT"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SUPPORT"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_create_error_from_info (current_: SUPPORT; a_code: INTEGER; a_name: STRING; a_description: STRING) is
		external
			"IL static signature (SUPPORT, System.Int32, STRING, STRING): System.Void use Implementation.SUPPORT"
		alias
			"$$create_error_from_info"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SUPPORT"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.SUPPORT"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_SUPPORT
