indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.SPECIAL_SINGLE"

external class
	IMPLEMENTATION_SPECIAL_SINGLE

inherit
	SPECIAL_SINGLE
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
			"IL creator use Implementation.SPECIAL_SINGLE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_native_array: NATIVE_ARRAY [REAL] is
		external
			"IL field signature :System.Single[] use Implementation.SPECIAL_SINGLE"
		alias
			"$$native_array"
		end

feature -- Basic Operations

	item (i: INTEGER): REAL is
		external
			"IL signature (System.Int32): System.Single use Implementation.SPECIAL_SINGLE"
		alias
			"item"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SPECIAL_SINGLE"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.SPECIAL_SINGLE"
		alias
			"GetHashCode"
		end

	infix "@" (i: INTEGER): REAL is
		external
			"IL signature (System.Int32): System.Single use Implementation.SPECIAL_SINGLE"
		alias
			"infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: SPECIAL_SINGLE; i: INTEGER): REAL is
		external
			"IL static signature (SPECIAL_SINGLE, System.Int32): System.Single use Implementation.SPECIAL_SINGLE"
		alias
			"$$item"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.SPECIAL_SINGLE"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.SPECIAL_SINGLE"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.SPECIAL_SINGLE"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SPECIAL_SINGLE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SPECIAL_SINGLE"
		alias
			"is_equal"
		end

	count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.SPECIAL_SINGLE"
		alias
			"count"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_native_array (current_: SPECIAL_SINGLE; a: NATIVE_ARRAY [REAL]) is
		external
			"IL static signature (SPECIAL_SINGLE, System.Single[]): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"$$make_from_native_array"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SPECIAL_SINGLE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SPECIAL_SINGLE"
		alias
			"same_type"
		end

	same_items (other: SPECIAL_SINGLE; upper: INTEGER): BOOLEAN is
		external
			"IL signature (SPECIAL_SINGLE, System.Int32): System.Boolean use Implementation.SPECIAL_SINGLE"
		alias
			"same_items"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.SPECIAL_SINGLE"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"internal_copy"
		end

	native_array: NATIVE_ARRAY [REAL] is
		external
			"IL signature (): System.Single[] use Implementation.SPECIAL_SINGLE"
		alias
			"native_array"
		end

	valid_array_type (a: NATIVE_ARRAY [REAL]): BOOLEAN is
		external
			"IL signature (System.Single[]): System.Boolean use Implementation.SPECIAL_SINGLE"
		alias
			"valid_array_type"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SPECIAL_SINGLE"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SPECIAL_SINGLE"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_index_of (current_: SPECIAL_SINGLE; v: REAL; start_position: INTEGER): INTEGER is
		external
			"IL static signature (SPECIAL_SINGLE, System.Single, System.Int32): System.Int32 use Implementation.SPECIAL_SINGLE"
		alias
			"$$index_of"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_array_type (current_: SPECIAL_SINGLE; a: NATIVE_ARRAY [REAL]): BOOLEAN is
		external
			"IL static signature (SPECIAL_SINGLE, System.Single[]): System.Boolean use Implementation.SPECIAL_SINGLE"
		alias
			"$$valid_array_type"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SPECIAL_SINGLE"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.SPECIAL_SINGLE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.SPECIAL_SINGLE"
		alias
			"default_pointer"
		end

	all_default (upper: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.SPECIAL_SINGLE"
		alias
			"all_default"
		end

	frozen ec_illegal_36_ec_illegal_36_clear_all (current_: SPECIAL_SINGLE) is
		external
			"IL static signature (SPECIAL_SINGLE): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"$$clear_all"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: SPECIAL_SINGLE; v: REAL; i: INTEGER) is
		external
			"IL static signature (SPECIAL_SINGLE, System.Single, System.Int32): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"$$put"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SPECIAL_SINGLE"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.SPECIAL_SINGLE"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SPECIAL_SINGLE"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.SPECIAL_SINGLE"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: SPECIAL_SINGLE; i: INTEGER): REAL is
		external
			"IL static signature (SPECIAL_SINGLE, System.Int32): System.Single use Implementation.SPECIAL_SINGLE"
		alias
			"$$infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_same_items (current_: SPECIAL_SINGLE; other: SPECIAL_SINGLE; upper: INTEGER): BOOLEAN is
		external
			"IL static signature (SPECIAL_SINGLE, SPECIAL_SINGLE, System.Int32): System.Boolean use Implementation.SPECIAL_SINGLE"
		alias
			"$$same_items"
		end

	frozen ec_illegal_36_ec_illegal_36_all_default (current_: SPECIAL_SINGLE; upper: INTEGER): BOOLEAN is
		external
			"IL static signature (SPECIAL_SINGLE, System.Int32): System.Boolean use Implementation.SPECIAL_SINGLE"
		alias
			"$$all_default"
		end

	make_from_native_array (a: NATIVE_ARRAY [REAL]) is
		external
			"IL signature (System.Single[]): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"make_from_native_array"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.SPECIAL_SINGLE"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_resized_area (current_: SPECIAL_SINGLE; n: INTEGER): SPECIAL_SINGLE is
		external
			"IL static signature (SPECIAL_SINGLE, System.Int32): SPECIAL_SINGLE use Implementation.SPECIAL_SINGLE"
		alias
			"$$resized_area"
		end

	index_of (v: REAL; start_position: INTEGER): INTEGER is
		external
			"IL signature (System.Single, System.Int32): System.Int32 use Implementation.SPECIAL_SINGLE"
		alias
			"index_of"
		end

	put (v: REAL; i: INTEGER) is
		external
			"IL signature (System.Single, System.Int32): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"put"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.SPECIAL_SINGLE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SPECIAL_SINGLE"
		alias
			"clone"
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"clear_all"
		end

	resized_area (n: INTEGER): SPECIAL_SINGLE is
		external
			"IL signature (System.Int32): SPECIAL_SINGLE use Implementation.SPECIAL_SINGLE"
		alias
			"resized_area"
		end

	a_set_native_array (native_array2: NATIVE_ARRAY [REAL]) is
		external
			"IL signature (System.Single[]): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"_set_native_array"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SPECIAL_SINGLE"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: SPECIAL_SINGLE; n: INTEGER) is
		external
			"IL static signature (SPECIAL_SINGLE, System.Int32): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"$$make"
		end

	frozen ec_illegal_36_ec_illegal_36_count (current_: SPECIAL_SINGLE): INTEGER is
		external
			"IL static signature (SPECIAL_SINGLE): System.Int32 use Implementation.SPECIAL_SINGLE"
		alias
			"$$count"
		end

	make (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"make"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.SPECIAL_SINGLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_SPECIAL_SINGLE
