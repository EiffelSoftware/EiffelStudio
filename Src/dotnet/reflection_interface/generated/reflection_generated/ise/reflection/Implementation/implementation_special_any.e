indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.SPECIAL_ANY"

external class
	IMPLEMENTATION_SPECIAL_ANY

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SPECIAL_ANY

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.SPECIAL_ANY"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_native_array: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL field signature :System.Object[] use Implementation.SPECIAL_ANY"
		alias
			"$$native_array"
		end

feature -- Basic Operations

	item (i: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.SPECIAL_ANY"
		alias
			"item"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SPECIAL_ANY"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.SPECIAL_ANY"
		alias
			"GetHashCode"
		end

	infix "@" (i: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.SPECIAL_ANY"
		alias
			"infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: SPECIAL_ANY; i: INTEGER): ANY is
		external
			"IL static signature (SPECIAL_ANY, System.Int32): ANY use Implementation.SPECIAL_ANY"
		alias
			"$$item"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.SPECIAL_ANY"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.SPECIAL_ANY"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.SPECIAL_ANY"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SPECIAL_ANY"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SPECIAL_ANY"
		alias
			"is_equal"
		end

	count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.SPECIAL_ANY"
		alias
			"count"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_native_array (current_: SPECIAL_ANY; a: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL static signature (SPECIAL_ANY, System.Object[]): System.Void use Implementation.SPECIAL_ANY"
		alias
			"$$make_from_native_array"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SPECIAL_ANY"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SPECIAL_ANY"
		alias
			"same_type"
		end

	same_items (other: SPECIAL_ANY; upper: INTEGER): BOOLEAN is
		external
			"IL signature (SPECIAL_ANY, System.Int32): System.Boolean use Implementation.SPECIAL_ANY"
		alias
			"same_items"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.SPECIAL_ANY"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SPECIAL_ANY"
		alias
			"internal_copy"
		end

	native_array: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use Implementation.SPECIAL_ANY"
		alias
			"native_array"
		end

	valid_array_type (a: NATIVE_ARRAY [SYSTEM_OBJECT]): BOOLEAN is
		external
			"IL signature (System.Object[]): System.Boolean use Implementation.SPECIAL_ANY"
		alias
			"valid_array_type"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SPECIAL_ANY"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SPECIAL_ANY"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_index_of (current_: SPECIAL_ANY; v: ANY; start_position: INTEGER): INTEGER is
		external
			"IL static signature (SPECIAL_ANY, ANY, System.Int32): System.Int32 use Implementation.SPECIAL_ANY"
		alias
			"$$index_of"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_array_type (current_: SPECIAL_ANY; a: NATIVE_ARRAY [SYSTEM_OBJECT]): BOOLEAN is
		external
			"IL static signature (SPECIAL_ANY, System.Object[]): System.Boolean use Implementation.SPECIAL_ANY"
		alias
			"$$valid_array_type"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SPECIAL_ANY"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.SPECIAL_ANY"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.SPECIAL_ANY"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.SPECIAL_ANY"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.SPECIAL_ANY"
		alias
			"default_pointer"
		end

	all_default (upper: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.SPECIAL_ANY"
		alias
			"all_default"
		end

	frozen ec_illegal_36_ec_illegal_36_clear_all (current_: SPECIAL_ANY) is
		external
			"IL static signature (SPECIAL_ANY): System.Void use Implementation.SPECIAL_ANY"
		alias
			"$$clear_all"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SPECIAL_ANY"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: SPECIAL_ANY; v: ANY; i: INTEGER) is
		external
			"IL static signature (SPECIAL_ANY, ANY, System.Int32): System.Void use Implementation.SPECIAL_ANY"
		alias
			"$$put"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SPECIAL_ANY"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.SPECIAL_ANY"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SPECIAL_ANY"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.SPECIAL_ANY"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: SPECIAL_ANY; i: INTEGER): ANY is
		external
			"IL static signature (SPECIAL_ANY, System.Int32): ANY use Implementation.SPECIAL_ANY"
		alias
			"$$infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_same_items (current_: SPECIAL_ANY; other: SPECIAL_ANY; upper: INTEGER): BOOLEAN is
		external
			"IL static signature (SPECIAL_ANY, SPECIAL_ANY, System.Int32): System.Boolean use Implementation.SPECIAL_ANY"
		alias
			"$$same_items"
		end

	frozen ec_illegal_36_ec_illegal_36_all_default (current_: SPECIAL_ANY; upper: INTEGER): BOOLEAN is
		external
			"IL static signature (SPECIAL_ANY, System.Int32): System.Boolean use Implementation.SPECIAL_ANY"
		alias
			"$$all_default"
		end

	make_from_native_array (a: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.Object[]): System.Void use Implementation.SPECIAL_ANY"
		alias
			"make_from_native_array"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.SPECIAL_ANY"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_resized_area (current_: SPECIAL_ANY; n: INTEGER): SPECIAL_ANY is
		external
			"IL static signature (SPECIAL_ANY, System.Int32): SPECIAL_ANY use Implementation.SPECIAL_ANY"
		alias
			"$$resized_area"
		end

	index_of (v: ANY; start_position: INTEGER): INTEGER is
		external
			"IL signature (ANY, System.Int32): System.Int32 use Implementation.SPECIAL_ANY"
		alias
			"index_of"
		end

	put (v: ANY; i: INTEGER) is
		external
			"IL signature (ANY, System.Int32): System.Void use Implementation.SPECIAL_ANY"
		alias
			"put"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.SPECIAL_ANY"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.SPECIAL_ANY"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SPECIAL_ANY"
		alias
			"clone"
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.SPECIAL_ANY"
		alias
			"clear_all"
		end

	resized_area (n: INTEGER): SPECIAL_ANY is
		external
			"IL signature (System.Int32): SPECIAL_ANY use Implementation.SPECIAL_ANY"
		alias
			"resized_area"
		end

	a_set_native_array (native_array2: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.Object[]): System.Void use Implementation.SPECIAL_ANY"
		alias
			"_set_native_array"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SPECIAL_ANY"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SPECIAL_ANY"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SPECIAL_ANY"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: SPECIAL_ANY; n: INTEGER) is
		external
			"IL static signature (SPECIAL_ANY, System.Int32): System.Void use Implementation.SPECIAL_ANY"
		alias
			"$$make"
		end

	frozen ec_illegal_36_ec_illegal_36_count (current_: SPECIAL_ANY): INTEGER is
		external
			"IL static signature (SPECIAL_ANY): System.Int32 use Implementation.SPECIAL_ANY"
		alias
			"$$count"
		end

	make (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.SPECIAL_ANY"
		alias
			"make"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SPECIAL_ANY"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.SPECIAL_ANY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_SPECIAL_ANY
