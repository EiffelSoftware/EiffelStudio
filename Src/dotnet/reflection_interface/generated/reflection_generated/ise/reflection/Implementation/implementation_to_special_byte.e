indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.TO_SPECIAL_BYTE"

external class
	IMPLEMENTATION_TO_SPECIAL_BYTE

inherit
	TO_SPECIAL_BYTE
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
			"IL creator use Implementation.TO_SPECIAL_BYTE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_area: SPECIAL_BYTE is
		external
			"IL field signature :SPECIAL_BYTE use Implementation.TO_SPECIAL_BYTE"
		alias
			"$$area"
		end

feature -- Basic Operations

	item (i: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use Implementation.TO_SPECIAL_BYTE"
		alias
			"item"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TO_SPECIAL_BYTE"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.TO_SPECIAL_BYTE"
		alias
			"GetHashCode"
		end

	infix "@" (i: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use Implementation.TO_SPECIAL_BYTE"
		alias
			"infix "@""
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.TO_SPECIAL_BYTE"
		alias
			"ToString"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.TO_SPECIAL_BYTE"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.TO_SPECIAL_BYTE"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.TO_SPECIAL_BYTE"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TO_SPECIAL_BYTE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TO_SPECIAL_BYTE"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_make_area (current_: TO_SPECIAL_BYTE; n: INTEGER) is
		external
			"IL static signature (TO_SPECIAL_BYTE, System.Int32): System.Void use Implementation.TO_SPECIAL_BYTE"
		alias
			"$$make_area"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TO_SPECIAL_BYTE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TO_SPECIAL_BYTE"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.TO_SPECIAL_BYTE"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TO_SPECIAL_BYTE"
		alias
			"internal_copy"
		end

	make_area (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.TO_SPECIAL_BYTE"
		alias
			"make_area"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TO_SPECIAL_BYTE"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TO_SPECIAL_BYTE"
		alias
			"equal"
		end

	set_area (other: SPECIAL_BYTE) is
		external
			"IL signature (SPECIAL_BYTE): System.Void use Implementation.TO_SPECIAL_BYTE"
		alias
			"set_area"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.TO_SPECIAL_BYTE"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.TO_SPECIAL_BYTE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.TO_SPECIAL_BYTE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.TO_SPECIAL_BYTE"
		alias
			"default_rescue"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TO_SPECIAL_BYTE"
		alias
			"standard_copy"
		end

	a_set_area (area2: SPECIAL_BYTE) is
		external
			"IL signature (SPECIAL_BYTE): System.Void use Implementation.TO_SPECIAL_BYTE"
		alias
			"_set_area"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TO_SPECIAL_BYTE"
		alias
			"valid_index"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.TO_SPECIAL_BYTE"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TO_SPECIAL_BYTE"
		alias
			"deep_equal"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.TO_SPECIAL_BYTE"
		alias
			"default_pointer"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.TO_SPECIAL_BYTE"
		alias
			"Equals"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.TO_SPECIAL_BYTE"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: TO_SPECIAL_BYTE; i: INTEGER): INTEGER_8 is
		external
			"IL static signature (TO_SPECIAL_BYTE, System.Int32): System.Byte use Implementation.TO_SPECIAL_BYTE"
		alias
			"$$item"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: TO_SPECIAL_BYTE; i: INTEGER): INTEGER_8 is
		external
			"IL static signature (TO_SPECIAL_BYTE, System.Int32): System.Byte use Implementation.TO_SPECIAL_BYTE"
		alias
			"$$infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_set_area (current_: TO_SPECIAL_BYTE; other: SPECIAL_BYTE) is
		external
			"IL static signature (TO_SPECIAL_BYTE, SPECIAL_BYTE): System.Void use Implementation.TO_SPECIAL_BYTE"
		alias
			"$$set_area"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: TO_SPECIAL_BYTE; v: INTEGER_8; i: INTEGER) is
		external
			"IL static signature (TO_SPECIAL_BYTE, System.Byte, System.Int32): System.Void use Implementation.TO_SPECIAL_BYTE"
		alias
			"$$put"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: TO_SPECIAL_BYTE; i: INTEGER): BOOLEAN is
		external
			"IL static signature (TO_SPECIAL_BYTE, System.Int32): System.Boolean use Implementation.TO_SPECIAL_BYTE"
		alias
			"$$valid_index"
		end

	put (v: INTEGER_8; i: INTEGER) is
		external
			"IL signature (System.Byte, System.Int32): System.Void use Implementation.TO_SPECIAL_BYTE"
		alias
			"put"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.TO_SPECIAL_BYTE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.TO_SPECIAL_BYTE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TO_SPECIAL_BYTE"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TO_SPECIAL_BYTE"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TO_SPECIAL_BYTE"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TO_SPECIAL_BYTE"
		alias
			"conforms_to"
		end

	area: SPECIAL_BYTE is
		external
			"IL signature (): SPECIAL_BYTE use Implementation.TO_SPECIAL_BYTE"
		alias
			"area"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TO_SPECIAL_BYTE"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.TO_SPECIAL_BYTE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_TO_SPECIAL_BYTE
