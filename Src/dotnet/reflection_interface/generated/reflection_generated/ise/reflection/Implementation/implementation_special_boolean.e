indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.SPECIAL_BOOLEAN"

external class
	IMPLEMENTATION_SPECIAL_BOOLEAN

inherit
	SPECIAL_BOOLEAN
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
			"IL creator use Implementation.SPECIAL_BOOLEAN"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_native_array: NATIVE_ARRAY [BOOLEAN] is
		external
			"IL field signature :System.Boolean[] use Implementation.SPECIAL_BOOLEAN"
		alias
			"$$native_array"
		end

feature -- Basic Operations

	item (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"item"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SPECIAL_BOOLEAN"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.SPECIAL_BOOLEAN"
		alias
			"GetHashCode"
		end

	infix "@" (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: SPECIAL_BOOLEAN; i: INTEGER): BOOLEAN is
		external
			"IL static signature (SPECIAL_BOOLEAN, System.Int32): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"$$item"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.SPECIAL_BOOLEAN"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.SPECIAL_BOOLEAN"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.SPECIAL_BOOLEAN"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"is_equal"
		end

	count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.SPECIAL_BOOLEAN"
		alias
			"count"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_native_array (current_: SPECIAL_BOOLEAN; a: NATIVE_ARRAY [BOOLEAN]) is
		external
			"IL static signature (SPECIAL_BOOLEAN, System.Boolean[]): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"$$make_from_native_array"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"same_type"
		end

	same_items (other: SPECIAL_BOOLEAN; upper: INTEGER): BOOLEAN is
		external
			"IL signature (SPECIAL_BOOLEAN, System.Int32): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"same_items"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.SPECIAL_BOOLEAN"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"internal_copy"
		end

	native_array: NATIVE_ARRAY [BOOLEAN] is
		external
			"IL signature (): System.Boolean[] use Implementation.SPECIAL_BOOLEAN"
		alias
			"native_array"
		end

	valid_array_type (a: NATIVE_ARRAY [BOOLEAN]): BOOLEAN is
		external
			"IL signature (System.Boolean[]): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"valid_array_type"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SPECIAL_BOOLEAN"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_index_of (current_: SPECIAL_BOOLEAN; v: BOOLEAN; start_position: INTEGER): INTEGER is
		external
			"IL static signature (SPECIAL_BOOLEAN, System.Boolean, System.Int32): System.Int32 use Implementation.SPECIAL_BOOLEAN"
		alias
			"$$index_of"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_array_type (current_: SPECIAL_BOOLEAN; a: NATIVE_ARRAY [BOOLEAN]): BOOLEAN is
		external
			"IL static signature (SPECIAL_BOOLEAN, System.Boolean[]): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"$$valid_array_type"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SPECIAL_BOOLEAN"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.SPECIAL_BOOLEAN"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.SPECIAL_BOOLEAN"
		alias
			"default_pointer"
		end

	all_default (upper: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"all_default"
		end

	frozen ec_illegal_36_ec_illegal_36_clear_all (current_: SPECIAL_BOOLEAN) is
		external
			"IL static signature (SPECIAL_BOOLEAN): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"$$clear_all"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: SPECIAL_BOOLEAN; v: BOOLEAN; i: INTEGER) is
		external
			"IL static signature (SPECIAL_BOOLEAN, System.Boolean, System.Int32): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"$$put"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SPECIAL_BOOLEAN"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.SPECIAL_BOOLEAN"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: SPECIAL_BOOLEAN; i: INTEGER): BOOLEAN is
		external
			"IL static signature (SPECIAL_BOOLEAN, System.Int32): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"$$infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_same_items (current_: SPECIAL_BOOLEAN; other: SPECIAL_BOOLEAN; upper: INTEGER): BOOLEAN is
		external
			"IL static signature (SPECIAL_BOOLEAN, SPECIAL_BOOLEAN, System.Int32): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"$$same_items"
		end

	frozen ec_illegal_36_ec_illegal_36_all_default (current_: SPECIAL_BOOLEAN; upper: INTEGER): BOOLEAN is
		external
			"IL static signature (SPECIAL_BOOLEAN, System.Int32): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"$$all_default"
		end

	make_from_native_array (a: NATIVE_ARRAY [BOOLEAN]) is
		external
			"IL signature (System.Boolean[]): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"make_from_native_array"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.SPECIAL_BOOLEAN"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_resized_area (current_: SPECIAL_BOOLEAN; n: INTEGER): SPECIAL_BOOLEAN is
		external
			"IL static signature (SPECIAL_BOOLEAN, System.Int32): SPECIAL_BOOLEAN use Implementation.SPECIAL_BOOLEAN"
		alias
			"$$resized_area"
		end

	index_of (v: BOOLEAN; start_position: INTEGER): INTEGER is
		external
			"IL signature (System.Boolean, System.Int32): System.Int32 use Implementation.SPECIAL_BOOLEAN"
		alias
			"index_of"
		end

	put (v: BOOLEAN; i: INTEGER) is
		external
			"IL signature (System.Boolean, System.Int32): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"put"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.SPECIAL_BOOLEAN"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SPECIAL_BOOLEAN"
		alias
			"clone"
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"clear_all"
		end

	resized_area (n: INTEGER): SPECIAL_BOOLEAN is
		external
			"IL signature (System.Int32): SPECIAL_BOOLEAN use Implementation.SPECIAL_BOOLEAN"
		alias
			"resized_area"
		end

	a_set_native_array (native_array2: NATIVE_ARRAY [BOOLEAN]) is
		external
			"IL signature (System.Boolean[]): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"_set_native_array"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SPECIAL_BOOLEAN"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: SPECIAL_BOOLEAN; n: INTEGER) is
		external
			"IL static signature (SPECIAL_BOOLEAN, System.Int32): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"$$make"
		end

	frozen ec_illegal_36_ec_illegal_36_count (current_: SPECIAL_BOOLEAN): INTEGER is
		external
			"IL static signature (SPECIAL_BOOLEAN): System.Int32 use Implementation.SPECIAL_BOOLEAN"
		alias
			"$$count"
		end

	make (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"make"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.SPECIAL_BOOLEAN"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_SPECIAL_BOOLEAN
