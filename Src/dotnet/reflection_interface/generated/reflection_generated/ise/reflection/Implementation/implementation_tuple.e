indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.TUPLE"

external class
	IMPLEMENTATION_TUPLE

inherit
	TUPLE
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
			"IL creator use Implementation.TUPLE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_native_array: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL field signature :System.Object[] use Implementation.TUPLE"
		alias
			"$$native_array"
		end

feature -- Basic Operations

	reference_code: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.TUPLE"
		alias
			"reference_code"
		end

	codemap: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use Implementation.TUPLE"
		alias
			"codemap"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.TUPLE"
		alias
			"____class_name"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.TUPLE"
		alias
			"tagged_out"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.TUPLE"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_convertible_to_real (current_: TUPLE): BOOLEAN is
		external
			"IL static signature (TUPLE): System.Boolean use Implementation.TUPLE"
		alias
			"$$convertible_to_real"
		end

	integer_64_item (index: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Int32): System.Int64 use Implementation.TUPLE"
		alias
			"integer_64_item"
		end

	fast_item (k: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use Implementation.TUPLE"
		alias
			"fast_item"
		end

	frozen ec_illegal_36_ec_illegal_36_boolean_arrayed (current_: TUPLE): ARRAY_BOOLEAN is
		external
			"IL static signature (TUPLE): ARRAY_BOOLEAN use Implementation.TUPLE"
		alias
			"$$boolean_arrayed"
		end

	frozen ec_illegal_36_ec_illegal_36_is_uniform_real (current_: TUPLE): BOOLEAN is
		external
			"IL static signature (TUPLE): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_uniform_real"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_16_item (current_: TUPLE; index: INTEGER): INTEGER_16 is
		external
			"IL static signature (TUPLE, System.Int32): System.Int16 use Implementation.TUPLE"
		alias
			"$$integer_16_item"
		end

	character_item (index: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.TUPLE"
		alias
			"character_item"
		end

	frozen ec_illegal_36_ec_illegal_36_is_reference_item (current_: TUPLE; index: INTEGER): BOOLEAN is
		external
			"IL static signature (TUPLE, System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_reference_item"
		end

	integer_16_item (index: INTEGER): INTEGER_16 is
		external
			"IL signature (System.Int32): System.Int16 use Implementation.TUPLE"
		alias
			"integer_16_item"
		end

	valid_typecode (code: INTEGER_8): BOOLEAN is
		external
			"IL signature (System.Byte): System.Boolean use Implementation.TUPLE"
		alias
			"valid_typecode"
		end

	real_arrayed: ARRAY_SINGLE is
		external
			"IL signature (): ARRAY_SINGLE use Implementation.TUPLE"
		alias
			"real_arrayed"
		end

	infix "@" (k: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.TUPLE"
		alias
			"infix "@""
		end

	pointer_arrayed: ARRAY_INTPTR is
		external
			"IL signature (): ARRAY_INTPTR use Implementation.TUPLE"
		alias
			"pointer_arrayed"
		end

	put (v: SYSTEM_OBJECT; k: INTEGER) is
		external
			"IL signature (System.Object, System.Int32): System.Void use Implementation.TUPLE"
		alias
			"put"
		end

	boolean_item (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"boolean_item"
		end

	frozen ec_illegal_36_ec_illegal_36_is_boolean_item (current_: TUPLE; index: INTEGER): BOOLEAN is
		external
			"IL static signature (TUPLE, System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_boolean_item"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TUPLE"
		alias
			"copy"
		end

	character_arrayed: ARRAY_CHAR is
		external
			"IL signature (): ARRAY_CHAR use Implementation.TUPLE"
		alias
			"character_arrayed"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.TUPLE"
		alias
			"generating_type"
		end

	convertible_to_double: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.TUPLE"
		alias
			"convertible_to_double"
		end

	real_item (index: INTEGER): REAL is
		external
			"IL signature (System.Int32): System.Single use Implementation.TUPLE"
		alias
			"real_item"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.TUPLE"
		alias
			"make"
		end

	item (k: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.TUPLE"
		alias
			"item"
		end

	frozen ec_illegal_36_ec_illegal_36_is_character_item (current_: TUPLE; index: INTEGER): BOOLEAN is
		external
			"IL static signature (TUPLE, System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_character_item"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.TUPLE"
		alias
			"out"
		end

	frozen ec_illegal_36_ec_illegal_36_is_uniform_pointer (current_: TUPLE): BOOLEAN is
		external
			"IL static signature (TUPLE): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_uniform_pointer"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_64_code (current_: TUPLE): INTEGER_8 is
		external
			"IL static signature (TUPLE): System.Byte use Implementation.TUPLE"
		alias
			"$$integer_64_code"
		end

	frozen ec_illegal_36_ec_illegal_36_real_code (current_: TUPLE): INTEGER_8 is
		external
			"IL static signature (TUPLE): System.Byte use Implementation.TUPLE"
		alias
			"$$real_code"
		end

	is_numeric_item (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"is_numeric_item"
		end

	frozen ec_illegal_36_ec_illegal_36_double_item (current_: TUPLE; index: INTEGER): DOUBLE is
		external
			"IL static signature (TUPLE, System.Int32): System.Double use Implementation.TUPLE"
		alias
			"$$double_item"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_16_code (current_: TUPLE): INTEGER_8 is
		external
			"IL static signature (TUPLE): System.Byte use Implementation.TUPLE"
		alias
			"$$integer_16_code"
		end

	upper: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.TUPLE"
		alias
			"upper"
		end

	frozen ec_illegal_36_ec_illegal_36_is_uniform_boolean (current_: TUPLE): BOOLEAN is
		external
			"IL static signature (TUPLE): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_uniform_boolean"
		end

	double_arrayed: ARRAY_DOUBLE is
		external
			"IL signature (): ARRAY_DOUBLE use Implementation.TUPLE"
		alias
			"double_arrayed"
		end

	double_code: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.TUPLE"
		alias
			"double_code"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: TUPLE) is
		external
			"IL static signature (TUPLE): System.Void use Implementation.TUPLE"
		alias
			"$$make"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: TUPLE; k: INTEGER): ANY is
		external
			"IL static signature (TUPLE, System.Int32): ANY use Implementation.TUPLE"
		alias
			"$$item"
		end

	is_uniform_reference: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.TUPLE"
		alias
			"is_uniform_reference"
		end

	frozen ec_illegal_36_ec_illegal_36_is_uniform_double (current_: TUPLE): BOOLEAN is
		external
			"IL static signature (TUPLE): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_uniform_double"
		end

	frozen ec_illegal_36_ec_illegal_36_upper (current_: TUPLE): INTEGER is
		external
			"IL static signature (TUPLE): System.Int32 use Implementation.TUPLE"
		alias
			"$$upper"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_code (current_: TUPLE): INTEGER_8 is
		external
			"IL static signature (TUPLE): System.Byte use Implementation.TUPLE"
		alias
			"$$integer_code"
		end

	frozen ec_illegal_36_ec_illegal_36_is_uniform_integer (current_: TUPLE): BOOLEAN is
		external
			"IL static signature (TUPLE): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_uniform_integer"
		end

	frozen ec_illegal_36_ec_illegal_36_is_integer_32 (current_: TUPLE; index: INTEGER): BOOLEAN is
		external
			"IL static signature (TUPLE, System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_integer_32"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_typecode (current_: TUPLE; code: INTEGER_8): BOOLEAN is
		external
			"IL static signature (TUPLE, System.Byte): System.Boolean use Implementation.TUPLE"
		alias
			"$$valid_typecode"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TUPLE"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_is_integer_8_item (current_: TUPLE; index: INTEGER): BOOLEAN is
		external
			"IL static signature (TUPLE, System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_integer_8_item"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.TUPLE"
		alias
			"io"
		end

	integer_32_item (index: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.TUPLE"
		alias
			"integer_32_item"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TUPLE"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_pointer_arrayed (current_: TUPLE): ARRAY_INTPTR is
		external
			"IL static signature (TUPLE): ARRAY_INTPTR use Implementation.TUPLE"
		alias
			"$$pointer_arrayed"
		end

	pointer_item (index: INTEGER): POINTER is
		external
			"IL signature (System.Int32): System.IntPtr use Implementation.TUPLE"
		alias
			"pointer_item"
		end

	frozen ec_illegal_36_ec_illegal_36_is_uniform_character (current_: TUPLE): BOOLEAN is
		external
			"IL static signature (TUPLE): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_uniform_character"
		end

	frozen ec_illegal_36_ec_illegal_36_arrayed (current_: TUPLE): ARRAY_ANY is
		external
			"IL static signature (TUPLE): ARRAY_ANY use Implementation.TUPLE"
		alias
			"$$arrayed"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.TUPLE"
		alias
			"operating_environment"
		end

	arrayed: ARRAY_ANY is
		external
			"IL signature (): ARRAY_ANY use Implementation.TUPLE"
		alias
			"arrayed"
		end

	boolean_arrayed: ARRAY_BOOLEAN is
		external
			"IL signature (): ARRAY_BOOLEAN use Implementation.TUPLE"
		alias
			"boolean_arrayed"
		end

	is_integer_64_item (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"is_integer_64_item"
		end

	is_reference_item (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"is_reference_item"
		end

	is_integer_item (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"is_integer_item"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.TUPLE"
		alias
			"default"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TUPLE"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_is_integer_64_item (current_: TUPLE; index: INTEGER): BOOLEAN is
		external
			"IL static signature (TUPLE, System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_integer_64_item"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TUPLE"
		alias
			"same_type"
		end

	arg_item_code (index: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use Implementation.TUPLE"
		alias
			"arg_item_code"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.TUPLE"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_character_code (current_: TUPLE): INTEGER_8 is
		external
			"IL static signature (TUPLE): System.Byte use Implementation.TUPLE"
		alias
			"$$character_code"
		end

	frozen ec_illegal_36_ec_illegal_36_string_arrayed (current_: TUPLE): ARRAY_ANY is
		external
			"IL static signature (TUPLE): ARRAY_ANY use Implementation.TUPLE"
		alias
			"$$string_arrayed"
		end

	frozen ec_illegal_36_ec_illegal_36_real_arrayed (current_: TUPLE): ARRAY_SINGLE is
		external
			"IL static signature (TUPLE): ARRAY_SINGLE use Implementation.TUPLE"
		alias
			"$$real_arrayed"
		end

	string_arrayed: ARRAY_ANY is
		external
			"IL signature (): ARRAY_ANY use Implementation.TUPLE"
		alias
			"string_arrayed"
		end

	is_uniform_pointer: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.TUPLE"
		alias
			"is_uniform_pointer"
		end

	frozen ec_illegal_36_ec_illegal_36_is_real_item (current_: TUPLE; index: INTEGER): BOOLEAN is
		external
			"IL static signature (TUPLE, System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_real_item"
		end

	is_tuple_uniform (code: INTEGER_8): BOOLEAN is
		external
			"IL signature (System.Byte): System.Boolean use Implementation.TUPLE"
		alias
			"is_tuple_uniform"
		end

	frozen ec_illegal_36_ec_illegal_36_boolean_item (current_: TUPLE; index: INTEGER): BOOLEAN is
		external
			"IL static signature (TUPLE, System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"$$boolean_item"
		end

	frozen ec_illegal_36_ec_illegal_36_is_numeric_item (current_: TUPLE; index: INTEGER): BOOLEAN is
		external
			"IL static signature (TUPLE, System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_numeric_item"
		end

	frozen ec_illegal_36_ec_illegal_36_character_item (current_: TUPLE; index: INTEGER): CHARACTER is
		external
			"IL static signature (TUPLE, System.Int32): System.Char use Implementation.TUPLE"
		alias
			"$$character_item"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_8_code (current_: TUPLE): INTEGER_8 is
		external
			"IL static signature (TUPLE): System.Byte use Implementation.TUPLE"
		alias
			"$$integer_8_code"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_8_item (current_: TUPLE; index: INTEGER): INTEGER_8 is
		external
			"IL static signature (TUPLE, System.Int32): System.Byte use Implementation.TUPLE"
		alias
			"$$integer_8_item"
		end

	frozen ec_illegal_36_ec_illegal_36_count (current_: TUPLE): INTEGER is
		external
			"IL static signature (TUPLE): System.Int32 use Implementation.TUPLE"
		alias
			"$$count"
		end

	frozen ec_illegal_36_ec_illegal_36_is_tuple_uniform (current_: TUPLE; code: INTEGER_8): BOOLEAN is
		external
			"IL static signature (TUPLE, System.Byte): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_tuple_uniform"
		end

	frozen ec_illegal_36_ec_illegal_36_pointer_item (current_: TUPLE; index: INTEGER): POINTER is
		external
			"IL static signature (TUPLE, System.Int32): System.IntPtr use Implementation.TUPLE"
		alias
			"$$pointer_item"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TUPLE"
		alias
			"standard_is_equal"
		end

	is_pointer_item (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"is_pointer_item"
		end

	boolean_code: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.TUPLE"
		alias
			"boolean_code"
		end

	double_item (index: INTEGER): DOUBLE is
		external
			"IL signature (System.Int32): System.Double use Implementation.TUPLE"
		alias
			"double_item"
		end

	frozen ec_illegal_36_ec_illegal_36_double_code (current_: TUPLE): INTEGER_8 is
		external
			"IL static signature (TUPLE): System.Byte use Implementation.TUPLE"
		alias
			"$$double_code"
		end

	frozen ec_illegal_36_ec_illegal_36_fast_item (current_: TUPLE; k: INTEGER): SYSTEM_OBJECT is
		external
			"IL static signature (TUPLE, System.Int32): System.Object use Implementation.TUPLE"
		alias
			"$$fast_item"
		end

	is_character_item (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"is_character_item"
		end

	integer_8_code: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.TUPLE"
		alias
			"integer_8_code"
		end

	integer_8_item (index: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use Implementation.TUPLE"
		alias
			"integer_8_item"
		end

	generic_typecode: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use Implementation.TUPLE"
		alias
			"generic_typecode"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_64_item (current_: TUPLE; index: INTEGER): INTEGER_64 is
		external
			"IL static signature (TUPLE, System.Int32): System.Int64 use Implementation.TUPLE"
		alias
			"$$integer_64_item"
		end

	is_uniform_integer: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.TUPLE"
		alias
			"is_uniform_integer"
		end

	integer_arrayed: ARRAY_INT32 is
		external
			"IL signature (): ARRAY_INT32 use Implementation.TUPLE"
		alias
			"integer_arrayed"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.TUPLE"
		alias
			"default_pointer"
		end

	is_uniform: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.TUPLE"
		alias
			"is_uniform"
		end

	real_code: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.TUPLE"
		alias
			"real_code"
		end

	frozen ec_illegal_36_ec_illegal_36_lower (current_: TUPLE): INTEGER is
		external
			"IL static signature (TUPLE): System.Int32 use Implementation.TUPLE"
		alias
			"$$lower"
		end

	integer_code: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.TUPLE"
		alias
			"integer_code"
		end

	integer_item (index: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.TUPLE"
		alias
			"integer_item"
		end

	is_integer_16_item (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"is_integer_16_item"
		end

	is_uniform_double: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.TUPLE"
		alias
			"is_uniform_double"
		end

	is_integer_32 (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"is_integer_32"
		end

	frozen ec_illegal_36_ec_illegal_36_character_arrayed (current_: TUPLE): ARRAY_CHAR is
		external
			"IL static signature (TUPLE): ARRAY_CHAR use Implementation.TUPLE"
		alias
			"$$character_arrayed"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TUPLE"
		alias
			"print"
		end

	valid_index (k: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"valid_index"
		end

	is_uniform_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.TUPLE"
		alias
			"is_uniform_boolean"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_32_item (current_: TUPLE; index: INTEGER): INTEGER is
		external
			"IL static signature (TUPLE, System.Int32): System.Int32 use Implementation.TUPLE"
		alias
			"$$integer_32_item"
		end

	character_code: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.TUPLE"
		alias
			"character_code"
		end

	frozen ec_illegal_36_ec_illegal_36_is_integer_16_item (current_: TUPLE; index: INTEGER): BOOLEAN is
		external
			"IL static signature (TUPLE, System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_integer_16_item"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TUPLE"
		alias
			"equal"
		end

	integer_16_code: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.TUPLE"
		alias
			"integer_16_code"
		end

	is_uniform_character: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.TUPLE"
		alias
			"is_uniform_character"
		end

	frozen ec_illegal_36_ec_illegal_36_codemap (current_: TUPLE): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL static signature (TUPLE): System.Object[] use Implementation.TUPLE"
		alias
			"$$codemap"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TUPLE"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TUPLE"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: TUPLE; k: INTEGER): BOOLEAN is
		external
			"IL static signature (TUPLE, System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"$$valid_index"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_arrayed (current_: TUPLE): ARRAY_INT32 is
		external
			"IL static signature (TUPLE): ARRAY_INT32 use Implementation.TUPLE"
		alias
			"$$integer_arrayed"
		end

	pointer_code: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.TUPLE"
		alias
			"pointer_code"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TUPLE"
		alias
			"standard_copy"
		end

	is_integer_8_item (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"is_integer_8_item"
		end

	native_array: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use Implementation.TUPLE"
		alias
			"native_array"
		end

	frozen ec_illegal_36_ec_illegal_36_convertible_to_double (current_: TUPLE): BOOLEAN is
		external
			"IL static signature (TUPLE): System.Boolean use Implementation.TUPLE"
		alias
			"$$convertible_to_double"
		end

	lower: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.TUPLE"
		alias
			"lower"
		end

	is_uniform_real: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.TUPLE"
		alias
			"is_uniform_real"
		end

	is_real_item (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"is_real_item"
		end

	frozen ec_illegal_36_ec_illegal_36_is_uniform_reference (current_: TUPLE): BOOLEAN is
		external
			"IL static signature (TUPLE): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_uniform_reference"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: TUPLE; k: INTEGER): ANY is
		external
			"IL static signature (TUPLE, System.Int32): ANY use Implementation.TUPLE"
		alias
			"$$infix "@""
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.TUPLE"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_real_item (current_: TUPLE; index: INTEGER): REAL is
		external
			"IL static signature (TUPLE, System.Int32): System.Single use Implementation.TUPLE"
		alias
			"$$real_item"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.TUPLE"
		alias
			"GetHashCode"
		end

	is_double_item (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"is_double_item"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TUPLE"
		alias
			"deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_is_integer_item (current_: TUPLE; index: INTEGER): BOOLEAN is
		external
			"IL static signature (TUPLE, System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_integer_item"
		end

	frozen ec_illegal_36_ec_illegal_36_double_arrayed (current_: TUPLE): ARRAY_DOUBLE is
		external
			"IL static signature (TUPLE): ARRAY_DOUBLE use Implementation.TUPLE"
		alias
			"$$double_arrayed"
		end

	frozen ec_illegal_36_ec_illegal_36_arg_item_code (current_: TUPLE; index: INTEGER): INTEGER_8 is
		external
			"IL static signature (TUPLE, System.Int32): System.Byte use Implementation.TUPLE"
		alias
			"$$arg_item_code"
		end

	frozen ec_illegal_36_ec_illegal_36_is_double_item (current_: TUPLE; index: INTEGER): BOOLEAN is
		external
			"IL static signature (TUPLE, System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_double_item"
		end

	is_boolean_item (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"is_boolean_item"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TUPLE"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_boolean_code (current_: TUPLE): INTEGER_8 is
		external
			"IL static signature (TUPLE): System.Byte use Implementation.TUPLE"
		alias
			"$$boolean_code"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: TUPLE; v: SYSTEM_OBJECT; k: INTEGER) is
		external
			"IL static signature (TUPLE, System.Object, System.Int32): System.Void use Implementation.TUPLE"
		alias
			"$$put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.TUPLE"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.TUPLE"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.TUPLE"
		alias
			"generator"
		end

	convertible_to_real: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.TUPLE"
		alias
			"convertible_to_real"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TUPLE"
		alias
			"internal_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_is_uniform (current_: TUPLE): BOOLEAN is
		external
			"IL static signature (TUPLE): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_uniform"
		end

	frozen ec_illegal_36_ec_illegal_36_generic_typecode (current_: TUPLE): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL static signature (TUPLE): System.Byte[] use Implementation.TUPLE"
		alias
			"$$generic_typecode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.TUPLE"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_item (current_: TUPLE; index: INTEGER): INTEGER is
		external
			"IL static signature (TUPLE, System.Int32): System.Int32 use Implementation.TUPLE"
		alias
			"$$integer_item"
		end

	frozen ec_illegal_36_ec_illegal_36_pointer_code (current_: TUPLE): INTEGER_8 is
		external
			"IL static signature (TUPLE): System.Byte use Implementation.TUPLE"
		alias
			"$$pointer_code"
		end

	count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.TUPLE"
		alias
			"count"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TUPLE"
		alias
			"deep_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_reference_code (current_: TUPLE): INTEGER_8 is
		external
			"IL static signature (TUPLE): System.Byte use Implementation.TUPLE"
		alias
			"$$reference_code"
		end

	a_set_native_array (native_array2: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.Object[]): System.Void use Implementation.TUPLE"
		alias
			"_set_native_array"
		end

	frozen ec_illegal_36_ec_illegal_36_is_pointer_item (current_: TUPLE; index: INTEGER): BOOLEAN is
		external
			"IL static signature (TUPLE, System.Int32): System.Boolean use Implementation.TUPLE"
		alias
			"$$is_pointer_item"
		end

	integer_64_code: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.TUPLE"
		alias
			"integer_64_code"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.TUPLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_TUPLE
