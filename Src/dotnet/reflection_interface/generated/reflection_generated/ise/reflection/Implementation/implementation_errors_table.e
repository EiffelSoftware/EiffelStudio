indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ERRORS_TABLE"

external class
	IMPLEMENTATION_ERRORS_TABLE

inherit
	ERRORS_TABLE
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
			"IL creator use Implementation.ERRORS_TABLE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_errors_table: HASH_TABLE_ANY_INT32 is
		external
			"IL field signature :HASH_TABLE_ANY_INT32 use Implementation.ERRORS_TABLE"
		alias
			"$$errors_table"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ERRORS_TABLE"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ERRORS_TABLE"
		alias
			"deep_clone"
		end

	error_info (a_code: INTEGER): ERROR_INFO is
		external
			"IL signature (System.Int32): ERROR_INFO use Implementation.ERRORS_TABLE"
		alias
			"error_info"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ERRORS_TABLE"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_add_error (current_: ERRORS_TABLE; an_error: ERROR_INFO) is
		external
			"IL static signature (ERRORS_TABLE, ERROR_INFO): System.Void use Implementation.ERRORS_TABLE"
		alias
			"$$add_error"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ERRORS_TABLE"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ERRORS_TABLE"
		alias
			"operating_environment"
		end

	frozen ec_illegal_36_ec_illegal_36_error_info (current_: ERRORS_TABLE; a_code: INTEGER): ERROR_INFO is
		external
			"IL static signature (ERRORS_TABLE, System.Int32): ERROR_INFO use Implementation.ERRORS_TABLE"
		alias
			"$$error_info"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ERRORS_TABLE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ERRORS_TABLE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ERRORS_TABLE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ERRORS_TABLE"
		alias
			"same_type"
		end

	frozen ec_illegal_36_ec_illegal_36_replace_error_description (current_: ERRORS_TABLE; a_code: INTEGER; new_description: STRING) is
		external
			"IL static signature (ERRORS_TABLE, System.Int32, STRING): System.Void use Implementation.ERRORS_TABLE"
		alias
			"$$replace_error_description"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ERRORS_TABLE"
		alias
			"generator"
		end

	replace_error_name (a_code: INTEGER; new_name: STRING) is
		external
			"IL signature (System.Int32, STRING): System.Void use Implementation.ERRORS_TABLE"
		alias
			"replace_error_name"
		end

	a_set_errors_table (errors_table2: HASH_TABLE_ANY_INT32) is
		external
			"IL signature (HASH_TABLE_ANY_INT32): System.Void use Implementation.ERRORS_TABLE"
		alias
			"_set_errors_table"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ERRORS_TABLE"
		alias
			"internal_copy"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ERRORS_TABLE"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ERRORS_TABLE"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_errors (current_: ERRORS_TABLE): LINKED_LIST_ANY is
		external
			"IL static signature (ERRORS_TABLE): LINKED_LIST_ANY use Implementation.ERRORS_TABLE"
		alias
			"$$errors"
		end

	add_error (an_error: ERROR_INFO) is
		external
			"IL signature (ERROR_INFO): System.Void use Implementation.ERRORS_TABLE"
		alias
			"add_error"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ERRORS_TABLE"
		alias
			"____class_name"
		end

	frozen ec_illegal_36_ec_illegal_36_replace_error_name (current_: ERRORS_TABLE; a_code: INTEGER; new_name: STRING) is
		external
			"IL static signature (ERRORS_TABLE, System.Int32, STRING): System.Void use Implementation.ERRORS_TABLE"
		alias
			"$$replace_error_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ERRORS_TABLE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ERRORS_TABLE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ERRORS_TABLE"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ERRORS_TABLE"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ERRORS_TABLE"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ERRORS_TABLE"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ERRORS_TABLE"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ERRORS_TABLE"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ERRORS_TABLE"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_error_description (current_: ERRORS_TABLE; a_code: INTEGER): STRING is
		external
			"IL static signature (ERRORS_TABLE, System.Int32): STRING use Implementation.ERRORS_TABLE"
		alias
			"$$error_description"
		end

	remove_error (a_code: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ERRORS_TABLE"
		alias
			"remove_error"
		end

	errors_table: HASH_TABLE_ANY_INT32 is
		external
			"IL signature (): HASH_TABLE_ANY_INT32 use Implementation.ERRORS_TABLE"
		alias
			"errors_table"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ERRORS_TABLE"
		alias
			"generating_type"
		end

	error_description (a_code: INTEGER): STRING is
		external
			"IL signature (System.Int32): STRING use Implementation.ERRORS_TABLE"
		alias
			"error_description"
		end

	replace_error_description (a_code: INTEGER; new_description: STRING) is
		external
			"IL signature (System.Int32, STRING): System.Void use Implementation.ERRORS_TABLE"
		alias
			"replace_error_description"
		end

	errors: LINKED_LIST_ANY is
		external
			"IL signature (): LINKED_LIST_ANY use Implementation.ERRORS_TABLE"
		alias
			"errors"
		end

	error_name (a_code: INTEGER): STRING is
		external
			"IL signature (System.Int32): STRING use Implementation.ERRORS_TABLE"
		alias
			"error_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ERRORS_TABLE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ERRORS_TABLE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ERRORS_TABLE"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ERRORS_TABLE"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ERRORS_TABLE"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ERRORS_TABLE"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: ERRORS_TABLE) is
		external
			"IL static signature (ERRORS_TABLE): System.Void use Implementation.ERRORS_TABLE"
		alias
			"$$make"
		end

	frozen ec_illegal_36_ec_illegal_36_error_name (current_: ERRORS_TABLE; a_code: INTEGER): STRING is
		external
			"IL static signature (ERRORS_TABLE, System.Int32): STRING use Implementation.ERRORS_TABLE"
		alias
			"$$error_name"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.ERRORS_TABLE"
		alias
			"make"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_error (current_: ERRORS_TABLE; a_code: INTEGER) is
		external
			"IL static signature (ERRORS_TABLE, System.Int32): System.Void use Implementation.ERRORS_TABLE"
		alias
			"$$remove_error"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ERRORS_TABLE"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ERRORS_TABLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ERRORS_TABLE
