indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ERROR_INFO"

external class
	IMPLEMENTATION_ERROR_INFO

inherit
	ERROR_INFO
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
			"IL creator use Implementation.ERROR_INFO"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_name: STRING is
		external
			"IL field signature :STRING use Implementation.ERROR_INFO"
		alias
			"$$name"
		end

	frozen ec_illegal_36_ec_illegal_36_description: STRING is
		external
			"IL field signature :STRING use Implementation.ERROR_INFO"
		alias
			"$$description"
		end

	frozen ec_illegal_36_ec_illegal_36_code: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ERROR_INFO"
		alias
			"$$code"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ERROR_INFO"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ERROR_INFO"
		alias
			"deep_clone"
		end

	code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ERROR_INFO"
		alias
			"code"
		end

	a_set_code (code2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ERROR_INFO"
		alias
			"_set_code"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ERROR_INFO"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ERROR_INFO"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ERROR_INFO"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ERROR_INFO"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ERROR_INFO"
		alias
			"is_equal"
		end

	name: STRING is
		external
			"IL signature (): STRING use Implementation.ERROR_INFO"
		alias
			"name"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ERROR_INFO"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ERROR_INFO"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ERROR_INFO"
		alias
			"generator"
		end

	a_set_name (name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.ERROR_INFO"
		alias
			"_set_name"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ERROR_INFO"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ERROR_INFO"
		alias
			"equal"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ERROR_INFO"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ERROR_INFO"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ERROR_INFO"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ERROR_INFO"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ERROR_INFO"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ERROR_INFO"
		alias
			"standard_copy"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ERROR_INFO"
		alias
			"internal_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ERROR_INFO"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ERROR_INFO"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ERROR_INFO"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ERROR_INFO"
		alias
			"Equals"
		end

	description: STRING is
		external
			"IL signature (): STRING use Implementation.ERROR_INFO"
		alias
			"description"
		end

	a_set_description (description2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.ERROR_INFO"
		alias
			"_set_description"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ERROR_INFO"
		alias
			"generating_type"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ERROR_INFO"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ERROR_INFO"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ERROR_INFO"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ERROR_INFO"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ERROR_INFO"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ERROR_INFO"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: ERROR_INFO; a_code: INTEGER; a_name: STRING; a_description: STRING) is
		external
			"IL static signature (ERROR_INFO, System.Int32, STRING, STRING): System.Void use Implementation.ERROR_INFO"
		alias
			"$$make"
		end

	make (a_code: INTEGER; a_name: STRING; a_description: STRING) is
		external
			"IL signature (System.Int32, STRING, STRING): System.Void use Implementation.ERROR_INFO"
		alias
			"make"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ERROR_INFO"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ERROR_INFO"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ERROR_INFO
