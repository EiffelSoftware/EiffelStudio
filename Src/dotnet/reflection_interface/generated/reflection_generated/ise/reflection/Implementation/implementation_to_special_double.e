indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.TO_SPECIAL_DOUBLE"

external class
	IMPLEMENTATION_TO_SPECIAL_DOUBLE

inherit
	TO_SPECIAL_DOUBLE
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
			"IL creator use Implementation.TO_SPECIAL_DOUBLE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_area: SPECIAL_DOUBLE is
		external
			"IL field signature :SPECIAL_DOUBLE use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"$$area"
		end

feature -- Basic Operations

	item (i: INTEGER): DOUBLE is
		external
			"IL signature (System.Int32): System.Double use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"item"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"GetHashCode"
		end

	infix "@" (i: INTEGER): DOUBLE is
		external
			"IL signature (System.Int32): System.Double use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"infix "@""
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"ToString"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_make_area (current_: TO_SPECIAL_DOUBLE; n: INTEGER) is
		external
			"IL static signature (TO_SPECIAL_DOUBLE, System.Int32): System.Void use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"$$make_area"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"internal_copy"
		end

	make_area (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"make_area"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"equal"
		end

	set_area (other: SPECIAL_DOUBLE) is
		external
			"IL signature (SPECIAL_DOUBLE): System.Void use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"set_area"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"default_rescue"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"standard_copy"
		end

	a_set_area (area2: SPECIAL_DOUBLE) is
		external
			"IL signature (SPECIAL_DOUBLE): System.Void use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"_set_area"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"valid_index"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"deep_equal"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"default_pointer"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"Equals"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: TO_SPECIAL_DOUBLE; i: INTEGER): DOUBLE is
		external
			"IL static signature (TO_SPECIAL_DOUBLE, System.Int32): System.Double use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"$$item"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: TO_SPECIAL_DOUBLE; i: INTEGER): DOUBLE is
		external
			"IL static signature (TO_SPECIAL_DOUBLE, System.Int32): System.Double use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"$$infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_set_area (current_: TO_SPECIAL_DOUBLE; other: SPECIAL_DOUBLE) is
		external
			"IL static signature (TO_SPECIAL_DOUBLE, SPECIAL_DOUBLE): System.Void use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"$$set_area"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: TO_SPECIAL_DOUBLE; v: DOUBLE; i: INTEGER) is
		external
			"IL static signature (TO_SPECIAL_DOUBLE, System.Double, System.Int32): System.Void use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"$$put"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: TO_SPECIAL_DOUBLE; i: INTEGER): BOOLEAN is
		external
			"IL static signature (TO_SPECIAL_DOUBLE, System.Int32): System.Boolean use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"$$valid_index"
		end

	put (v: DOUBLE; i: INTEGER) is
		external
			"IL signature (System.Double, System.Int32): System.Void use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"put"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"conforms_to"
		end

	area: SPECIAL_DOUBLE is
		external
			"IL signature (): SPECIAL_DOUBLE use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"area"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.TO_SPECIAL_DOUBLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_TO_SPECIAL_DOUBLE
