indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.TO_SPECIAL_SINGLE"

external class
	IMPLEMENTATION_TO_SPECIAL_SINGLE

inherit
	TO_SPECIAL_SINGLE
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
			"IL creator use Implementation.TO_SPECIAL_SINGLE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_area: SPECIAL_SINGLE is
		external
			"IL field signature :SPECIAL_SINGLE use Implementation.TO_SPECIAL_SINGLE"
		alias
			"$$area"
		end

feature -- Basic Operations

	item (i: INTEGER): REAL is
		external
			"IL signature (System.Int32): System.Single use Implementation.TO_SPECIAL_SINGLE"
		alias
			"item"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TO_SPECIAL_SINGLE"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.TO_SPECIAL_SINGLE"
		alias
			"GetHashCode"
		end

	infix "@" (i: INTEGER): REAL is
		external
			"IL signature (System.Int32): System.Single use Implementation.TO_SPECIAL_SINGLE"
		alias
			"infix "@""
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.TO_SPECIAL_SINGLE"
		alias
			"ToString"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.TO_SPECIAL_SINGLE"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.TO_SPECIAL_SINGLE"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.TO_SPECIAL_SINGLE"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TO_SPECIAL_SINGLE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TO_SPECIAL_SINGLE"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_make_area (current_: TO_SPECIAL_SINGLE; n: INTEGER) is
		external
			"IL static signature (TO_SPECIAL_SINGLE, System.Int32): System.Void use Implementation.TO_SPECIAL_SINGLE"
		alias
			"$$make_area"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TO_SPECIAL_SINGLE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TO_SPECIAL_SINGLE"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.TO_SPECIAL_SINGLE"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TO_SPECIAL_SINGLE"
		alias
			"internal_copy"
		end

	make_area (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.TO_SPECIAL_SINGLE"
		alias
			"make_area"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TO_SPECIAL_SINGLE"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TO_SPECIAL_SINGLE"
		alias
			"equal"
		end

	set_area (other: SPECIAL_SINGLE) is
		external
			"IL signature (SPECIAL_SINGLE): System.Void use Implementation.TO_SPECIAL_SINGLE"
		alias
			"set_area"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.TO_SPECIAL_SINGLE"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.TO_SPECIAL_SINGLE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.TO_SPECIAL_SINGLE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.TO_SPECIAL_SINGLE"
		alias
			"default_rescue"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TO_SPECIAL_SINGLE"
		alias
			"standard_copy"
		end

	a_set_area (area2: SPECIAL_SINGLE) is
		external
			"IL signature (SPECIAL_SINGLE): System.Void use Implementation.TO_SPECIAL_SINGLE"
		alias
			"_set_area"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TO_SPECIAL_SINGLE"
		alias
			"valid_index"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.TO_SPECIAL_SINGLE"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TO_SPECIAL_SINGLE"
		alias
			"deep_equal"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.TO_SPECIAL_SINGLE"
		alias
			"default_pointer"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.TO_SPECIAL_SINGLE"
		alias
			"Equals"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.TO_SPECIAL_SINGLE"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: TO_SPECIAL_SINGLE; i: INTEGER): REAL is
		external
			"IL static signature (TO_SPECIAL_SINGLE, System.Int32): System.Single use Implementation.TO_SPECIAL_SINGLE"
		alias
			"$$item"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: TO_SPECIAL_SINGLE; i: INTEGER): REAL is
		external
			"IL static signature (TO_SPECIAL_SINGLE, System.Int32): System.Single use Implementation.TO_SPECIAL_SINGLE"
		alias
			"$$infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_set_area (current_: TO_SPECIAL_SINGLE; other: SPECIAL_SINGLE) is
		external
			"IL static signature (TO_SPECIAL_SINGLE, SPECIAL_SINGLE): System.Void use Implementation.TO_SPECIAL_SINGLE"
		alias
			"$$set_area"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: TO_SPECIAL_SINGLE; v: REAL; i: INTEGER) is
		external
			"IL static signature (TO_SPECIAL_SINGLE, System.Single, System.Int32): System.Void use Implementation.TO_SPECIAL_SINGLE"
		alias
			"$$put"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: TO_SPECIAL_SINGLE; i: INTEGER): BOOLEAN is
		external
			"IL static signature (TO_SPECIAL_SINGLE, System.Int32): System.Boolean use Implementation.TO_SPECIAL_SINGLE"
		alias
			"$$valid_index"
		end

	put (v: REAL; i: INTEGER) is
		external
			"IL signature (System.Single, System.Int32): System.Void use Implementation.TO_SPECIAL_SINGLE"
		alias
			"put"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.TO_SPECIAL_SINGLE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.TO_SPECIAL_SINGLE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TO_SPECIAL_SINGLE"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TO_SPECIAL_SINGLE"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TO_SPECIAL_SINGLE"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TO_SPECIAL_SINGLE"
		alias
			"conforms_to"
		end

	area: SPECIAL_SINGLE is
		external
			"IL signature (): SPECIAL_SINGLE use Implementation.TO_SPECIAL_SINGLE"
		alias
			"area"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TO_SPECIAL_SINGLE"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.TO_SPECIAL_SINGLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_TO_SPECIAL_SINGLE
