indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.OPERATING_ENVIRONMENT"

external class
	IMPLEMENTATION_OPERATING_ENVIRONMENT

inherit
	OPERATING_ENVIRONMENT
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.OPERATING_ENVIRONMENT"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.OPERATING_ENVIRONMENT"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.OPERATING_ENVIRONMENT"
		alias
			"deep_clone"
		end

	root_directory_supported: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.OPERATING_ENVIRONMENT"
		alias
			"root_directory_supported"
		end

	frozen ec_illegal_36_ec_illegal_36_home_directory_supported (current_: OPERATING_ENVIRONMENT): BOOLEAN is
		external
			"IL static signature (OPERATING_ENVIRONMENT): System.Boolean use Implementation.OPERATING_ENVIRONMENT"
		alias
			"$$home_directory_supported"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.OPERATING_ENVIRONMENT"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.OPERATING_ENVIRONMENT"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.OPERATING_ENVIRONMENT"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.OPERATING_ENVIRONMENT"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.OPERATING_ENVIRONMENT"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.OPERATING_ENVIRONMENT"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.OPERATING_ENVIRONMENT"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.OPERATING_ENVIRONMENT"
		alias
			"generator"
		end

	home_directory_supported: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.OPERATING_ENVIRONMENT"
		alias
			"home_directory_supported"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.OPERATING_ENVIRONMENT"
		alias
			"internal_copy"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.OPERATING_ENVIRONMENT"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.OPERATING_ENVIRONMENT"
		alias
			"equal"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.OPERATING_ENVIRONMENT"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.OPERATING_ENVIRONMENT"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.OPERATING_ENVIRONMENT"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.OPERATING_ENVIRONMENT"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.OPERATING_ENVIRONMENT"
		alias
			"default_pointer"
		end

	frozen ec_illegal_36_ec_illegal_36_root_directory_supported (current_: OPERATING_ENVIRONMENT): BOOLEAN is
		external
			"IL static signature (OPERATING_ENVIRONMENT): System.Boolean use Implementation.OPERATING_ENVIRONMENT"
		alias
			"$$root_directory_supported"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.OPERATING_ENVIRONMENT"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.OPERATING_ENVIRONMENT"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_directory_separator (current_: OPERATING_ENVIRONMENT): CHARACTER is
		external
			"IL static signature (OPERATING_ENVIRONMENT): System.Char use Implementation.OPERATING_ENVIRONMENT"
		alias
			"$$directory_separator"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.OPERATING_ENVIRONMENT"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.OPERATING_ENVIRONMENT"
		alias
			"deep_equal"
		end

	case_sensitive_path_names: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.OPERATING_ENVIRONMENT"
		alias
			"case_sensitive_path_names"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.OPERATING_ENVIRONMENT"
		alias
			"Equals"
		end

	current_directory_name_representation: STRING is
		external
			"IL signature (): STRING use Implementation.OPERATING_ENVIRONMENT"
		alias
			"current_directory_name_representation"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.OPERATING_ENVIRONMENT"
		alias
			"generating_type"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.OPERATING_ENVIRONMENT"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.OPERATING_ENVIRONMENT"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.OPERATING_ENVIRONMENT"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_current_directory_name_representation (current_: OPERATING_ENVIRONMENT): STRING is
		external
			"IL static signature (OPERATING_ENVIRONMENT): STRING use Implementation.OPERATING_ENVIRONMENT"
		alias
			"$$current_directory_name_representation"
		end

	frozen ec_illegal_36_ec_illegal_36_case_sensitive_path_names (current_: OPERATING_ENVIRONMENT): BOOLEAN is
		external
			"IL static signature (OPERATING_ENVIRONMENT): System.Boolean use Implementation.OPERATING_ENVIRONMENT"
		alias
			"$$case_sensitive_path_names"
		end

	directory_separator: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.OPERATING_ENVIRONMENT"
		alias
			"directory_separator"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.OPERATING_ENVIRONMENT"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.OPERATING_ENVIRONMENT"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.OPERATING_ENVIRONMENT"
		alias
			"conforms_to"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.OPERATING_ENVIRONMENT"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.OPERATING_ENVIRONMENT"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_OPERATING_ENVIRONMENT
