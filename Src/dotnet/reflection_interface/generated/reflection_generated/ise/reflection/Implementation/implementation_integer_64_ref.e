indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.INTEGER_64_REF"

external class
	IMPLEMENTATION_INTEGER_64_REF

inherit
	HASHABLE
	INTEGER_64_REF
		rename
			debug_output as out_,
			infix "/" as a__infixec_illegal_32_ec_illegal_34_ec_illegal_47_ec_illegal_34_39
		end
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	COMPARABLE
	DEBUG_OUTPUT
		rename
			debug_output as out_
		end
	NUMERIC
		rename
			debug_output as out_,
			infix "/" as a__infixec_illegal_32_ec_illegal_34_ec_illegal_47_ec_illegal_34_39
		end
	PART_COMPARABLE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.INTEGER_64_REF"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_item: INTEGER_64 is
		external
			"IL field signature :System.Int64 use Implementation.INTEGER_64_REF"
		alias
			"$$item"
		end

feature -- Basic Operations

	to_integer_8: INTEGER_8 is
		external
			"IL signature (): System.Byte use Implementation.INTEGER_64_REF"
		alias
			"to_integer_8"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.INTEGER_64_REF"
		alias
			"operating_environment"
		end

	bit_not: INTEGER_64_REF is
		external
			"IL signature (): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"bit_not"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.INTEGER_64_REF"
		alias
			"____class_name"
		end

	set_bit (b: BOOLEAN; n: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Boolean, System.Int32): System.Int64 use Implementation.INTEGER_64_REF"
		alias
			"set_bit"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.INTEGER_64_REF"
		alias
			"default_create"
		end

	infix "-" (other: NUMERIC): NUMERIC is
		external
			"IL signature (NUMERIC): NUMERIC use Implementation.INTEGER_64_REF"
		alias
			"infix "-""
		end

	infix "|<<" (n: INTEGER): INTEGER_64_REF is
		external
			"IL signature (System.Int32): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"infix "|<<""
		end

	frozen ec_illegal_34__in_ec_illegal_36_ec_illegal_36_prefixec_illegal_32_ec_illegal_34_ (current_: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$prefix "+""
		end

	set_bit_with_mask (b: BOOLEAN; m: INTEGER_64): INTEGER_64 is
		external
			"IL signature (System.Boolean, System.Int64): System.Int64 use Implementation.INTEGER_64_REF"
		alias
			"set_bit_with_mask"
		end

	exponentiable (other: NUMERIC): BOOLEAN is
		external
			"IL signature (NUMERIC): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"exponentiable"
		end

	ec_illegal_34__in_prefixec_illegal_32_ec_illegal_34_: NUMERIC is
		external
			"IL signature (): NUMERIC use Implementation.INTEGER_64_REF"
		alias
			"prefix "+""
		end

	ec_illegal_34__in_infix " (other: NUMERIC): NUMERIC is
		external
			"IL signature (NUMERIC): NUMERIC use Implementation.INTEGER_64_REF"
		alias
			"infix "+""
		end

	frozen ec_illegal_36_ec_illegal_36_divisible (current_: INTEGER_64_REF; other: INTEGER_64_REF): BOOLEAN is
		external
			"IL static signature (INTEGER_64_REF, INTEGER_64_REF): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"$$divisible"
		end

	infix "^" (other: NUMERIC): DOUBLE is
		external
			"IL signature (NUMERIC): System.Double use Implementation.INTEGER_64_REF"
		alias
			"infix "^""
		end

	bit_xor (i: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL signature (INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"bit_xor"
		end

	frozen ec_illegal_36_ec_illegal_36_set_bit (current_: INTEGER_64_REF; b: BOOLEAN; n: INTEGER): INTEGER_64 is
		external
			"IL static signature (INTEGER_64_REF, System.Boolean, System.Int32): System.Int64 use Implementation.INTEGER_64_REF"
		alias
			"$$set_bit"
		end

	max (other: COMPARABLE): COMPARABLE is
		external
			"IL signature (COMPARABLE): COMPARABLE use Implementation.INTEGER_64_REF"
		alias
			"max"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INTEGER_64_REF"
		alias
			"copy"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_47_ec_illegal_34_ (current_: INTEGER_64_REF; other: INTEGER_64_REF): DOUBLE is
		external
			"IL static signature (INTEGER_64_REF, INTEGER_64_REF): System.Double use Implementation.INTEGER_64_REF"
		alias
			"$$infix "/""
		end

	infix ">" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"infix ">""
		end

	frozen ec_illegal_36_ec_illegal_36_bit_not (current_: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$bit_not"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.INTEGER_64_REF"
		alias
			"generating_type"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.INTEGER_64_REF"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_abs (current_: INTEGER_64_REF): INTEGER_64 is
		external
			"IL static signature (INTEGER_64_REF): System.Int64 use Implementation.INTEGER_64_REF"
		alias
			"$$abs"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_124_ec_illegal_62_ec_illegal_62_ec_illegal_34_ (current_: INTEGER_64_REF; n: INTEGER): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF, System.Int32): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$infix "|>>""
		end

	item: INTEGER_64 is
		external
			"IL signature (): System.Int64 use Implementation.INTEGER_64_REF"
		alias
			"item"
		end

	min (other: COMPARABLE): COMPARABLE is
		external
			"IL signature (COMPARABLE): COMPARABLE use Implementation.INTEGER_64_REF"
		alias
			"min"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.INTEGER_64_REF"
		alias
			"out"
		end

	prefixec_illegal_32_ec_illegal_34_ec_illegal_45_ec_illegal_34_: NUMERIC is
		external
			"IL signature (): NUMERIC use Implementation.INTEGER_64_REF"
		alias
			"prefix "-""
		end

	infix "|>>" (n: INTEGER): INTEGER_64_REF is
		external
			"IL signature (System.Int32): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"infix "|>>""
		end

	infix "<=" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"infix "<=""
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_45_ec_illegal_34_ (current_: INTEGER_64_REF; other: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF, INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$infix "-""
		end

	hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTEGER_64_REF"
		alias
			"hash_code"
		end

	infix "/"_integer_64_ref (other: INTEGER_64_REF): DOUBLE is
		external
			"IL signature (INTEGER_64_REF): System.Double use Implementation.INTEGER_64_REF"
		alias
			"infix "/""
		end

	frozen ec_illegal_36_ec_illegal_36_to_integer (current_: INTEGER_64_REF): INTEGER is
		external
			"IL static signature (INTEGER_64_REF): System.Int32 use Implementation.INTEGER_64_REF"
		alias
			"$$to_integer"
		end

	frozen ec_illegal_36_ec_illegal_36_out (current_: INTEGER_64_REF): STRING is
		external
			"IL static signature (INTEGER_64_REF): STRING use Implementation.INTEGER_64_REF"
		alias
			"$$out"
		end

	infix "*" (other: NUMERIC): NUMERIC is
		external
			"IL signature (NUMERIC): NUMERIC use Implementation.INTEGER_64_REF"
		alias
			"infix "*""
		end

	frozen ec_illegal_36_ec_illegal_36_to_integer_8 (current_: INTEGER_64_REF): INTEGER_8 is
		external
			"IL static signature (INTEGER_64_REF): System.Byte use Implementation.INTEGER_64_REF"
		alias
			"$$to_integer_8"
		end

	to_character: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.INTEGER_64_REF"
		alias
			"to_character"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"conforms_to"
		end

	infix ">=" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"infix ">=""
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.INTEGER_64_REF"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_abs_ref (current_: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$abs_ref"
		end

	frozen ec_illegal_36_ec_illegal_36_one (current_: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$one"
		end

	frozen ec_illegal_36_ec_illegal_36_bit_shift (current_: INTEGER_64_REF; n: INTEGER): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF, System.Int32): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$bit_shift"
		end

	bit_and (i: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL signature (INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"bit_and"
		end

	divisible (other: NUMERIC): BOOLEAN is
		external
			"IL signature (NUMERIC): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"divisible"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.INTEGER_64_REF"
		alias
			"tagged_out"
		end

	ascii_char: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.INTEGER_64_REF"
		alias
			"ascii_char"
		end

	zero: NUMERIC is
		external
			"IL signature (): NUMERIC use Implementation.INTEGER_64_REF"
		alias
			"zero"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.INTEGER_64_REF"
		alias
			"default"
		end

	is_valid_character_code: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"is_valid_character_code"
		end

	bit_or (i: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL signature (INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"bit_or"
		end

	set_item (i: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use Implementation.INTEGER_64_REF"
		alias
			"set_item"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"same_type"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.INTEGER_64_REF"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_38_ec_illegal_34_ (current_: INTEGER_64_REF; i: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF, INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$infix "&""
		end

	abs: INTEGER_64 is
		external
			"IL signature (): System.Int64 use Implementation.INTEGER_64_REF"
		alias
			"abs"
		end

	frozen ec_illegal_36_ec_illegal_36_is_hashable (current_: INTEGER_64_REF): BOOLEAN is
		external
			"IL static signature (INTEGER_64_REF): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"$$is_hashable"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_94_ec_illegal_34_ (current_: INTEGER_64_REF; other: NUMERIC): DOUBLE is
		external
			"IL static signature (INTEGER_64_REF, NUMERIC): System.Double use Implementation.INTEGER_64_REF"
		alias
			"$$infix "^""
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_42_ec_illegal_34_ (current_: INTEGER_64_REF; other: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF, INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$infix "*""
		end

	frozen ec_illegal_36_ec_illegal_36_ascii_char (current_: INTEGER_64_REF): CHARACTER is
		external
			"IL static signature (INTEGER_64_REF): System.Char use Implementation.INTEGER_64_REF"
		alias
			"$$ascii_char"
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: INTEGER_64_REF; other: INTEGER_64_REF): BOOLEAN is
		external
			"IL static signature (INTEGER_64_REF, INTEGER_64_REF): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"$$is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_bit_and (current_: INTEGER_64_REF; i: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF, INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$bit_and"
		end

	infix "//" (other: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL signature (INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"infix "//""
		end

	infix "\\" (other: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL signature (INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"infix "\\""
		end

	frozen ec_illegal_36_ec_illegal_36_bit_test (current_: INTEGER_64_REF; n: INTEGER): BOOLEAN is
		external
			"IL static signature (INTEGER_64_REF, System.Int32): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"$$bit_test"
		end

	frozen ec_illegal_36_ec_illegal_36_bit_or (current_: INTEGER_64_REF; i: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF, INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$bit_or"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"standard_is_equal"
		end

	three_way_comparison (other: COMPARABLE): INTEGER is
		external
			"IL signature (COMPARABLE): System.Int32 use Implementation.INTEGER_64_REF"
		alias
			"three_way_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_to_integer_16 (current_: INTEGER_64_REF): INTEGER_16 is
		external
			"IL static signature (INTEGER_64_REF): System.Int16 use Implementation.INTEGER_64_REF"
		alias
			"$$to_integer_16"
		end

	to_integer: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTEGER_64_REF"
		alias
			"to_integer"
		end

	frozen ec_illegal_36_ec_illegal_36_set_bit_with_mask (current_: INTEGER_64_REF; b: BOOLEAN; m: INTEGER_64): INTEGER_64 is
		external
			"IL static signature (INTEGER_64_REF, System.Boolean, System.Int64): System.Int64 use Implementation.INTEGER_64_REF"
		alias
			"$$set_bit_with_mask"
		end

	abs_ref: INTEGER_64_REF is
		external
			"IL signature (): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"abs_ref"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"equal"
		end

	bit_shift_left (n: INTEGER): INTEGER_64_REF is
		external
			"IL signature (System.Int32): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"bit_shift_left"
		end

	to_integer_16: INTEGER_16 is
		external
			"IL signature (): System.Int16 use Implementation.INTEGER_64_REF"
		alias
			"to_integer_16"
		end

	infix "|" (i: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL signature (INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"infix "|""
		end

	one: NUMERIC is
		external
			"IL signature (): NUMERIC use Implementation.INTEGER_64_REF"
		alias
			"one"
		end

	is_hashable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"is_hashable"
		end

	bit_shift_right (n: INTEGER): INTEGER_64_REF is
		external
			"IL signature (System.Int32): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"bit_shift_right"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_47_ec_illegal_47_ec_illegal_34_ (current_: INTEGER_64_REF; other: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF, INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$infix "//""
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.INTEGER_64_REF"
		alias
			"default_pointer"
		end

	bit_shift (n: INTEGER): INTEGER_64_REF is
		external
			"IL signature (System.Int32): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"bit_shift"
		end

	frozen ec_illegal_36_ec_illegal_36_prefixec_illegal_32_ec_illegal_34_ec_illegal_45_ec_illegal_34_ (current_: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$prefix "-""
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_is_valid_character_code (current_: INTEGER_64_REF): BOOLEAN is
		external
			"IL static signature (INTEGER_64_REF): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"$$is_valid_character_code"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_60_ec_illegal_34_ (current_: INTEGER_64_REF; other: INTEGER_64_REF): BOOLEAN is
		external
			"IL static signature (INTEGER_64_REF, INTEGER_64_REF): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"$$infix "<""
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INTEGER_64_REF"
		alias
			"print"
		end

	bit_test (n: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"bit_test"
		end

	frozen ec_illegal_36_ec_illegal_36_three_way_comparison (current_: INTEGER_64_REF; other: INTEGER_64_REF): INTEGER is
		external
			"IL static signature (INTEGER_64_REF, INTEGER_64_REF): System.Int32 use Implementation.INTEGER_64_REF"
		alias
			"$$three_way_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_124_ec_illegal_60_ec_illegal_60_ec_illegal_34_ (current_: INTEGER_64_REF; n: INTEGER): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF, System.Int32): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$infix "|<<""
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.INTEGER_64_REF"
		alias
			"generator"
		end

	frozen ec_illegal_34__in_ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ (current_: INTEGER_64_REF; other: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF, INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$infix "+""
		end

	frozen ec_illegal_36_ec_illegal_36_zero (current_: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$zero"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.INTEGER_64_REF"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"standard_equal"
		end

	infix "<" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"infix "<""
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INTEGER_64_REF"
		alias
			"standard_copy"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_bit_xor (current_: INTEGER_64_REF; i: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF, INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$bit_xor"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTEGER_64_REF"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_bit_shift_right (current_: INTEGER_64_REF; n: INTEGER): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF, System.Int32): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$bit_shift_right"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"deep_equal"
		end

	sign: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTEGER_64_REF"
		alias
			"sign"
		end

	a_set_item (item2: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use Implementation.INTEGER_64_REF"
		alias
			"_set_item"
		end

	frozen ec_illegal_36_ec_illegal_36_set_item (current_: INTEGER_64_REF; i: INTEGER_64) is
		external
			"IL static signature (INTEGER_64_REF, System.Int64): System.Void use Implementation.INTEGER_64_REF"
		alias
			"$$set_item"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.INTEGER_64_REF"
		alias
			"default_rescue"
		end

	frozen ec_illegal_36_ec_illegal_36_exponentiable (current_: INTEGER_64_REF; other: NUMERIC): BOOLEAN is
		external
			"IL static signature (INTEGER_64_REF, NUMERIC): System.Boolean use Implementation.INTEGER_64_REF"
		alias
			"$$exponentiable"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.INTEGER_64_REF"
		alias
			"internal_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_92_ec_illegal_92_ec_illegal_34_ (current_: INTEGER_64_REF; other: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF, INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$infix "\\""
		end

	infix "&" (i: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL signature (INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"infix "&""
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INTEGER_64_REF"
		alias
			"internal_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_to_character (current_: INTEGER_64_REF): CHARACTER is
		external
			"IL static signature (INTEGER_64_REF): System.Char use Implementation.INTEGER_64_REF"
		alias
			"$$to_character"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.INTEGER_64_REF"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_124_ec_illegal_34_ (current_: INTEGER_64_REF; i: INTEGER_64_REF): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF, INTEGER_64_REF): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$infix "|""
		end

	frozen ec_illegal_36_ec_illegal_36_hash_code (current_: INTEGER_64_REF): INTEGER is
		external
			"IL static signature (INTEGER_64_REF): System.Int32 use Implementation.INTEGER_64_REF"
		alias
			"$$hash_code"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INTEGER_64_REF"
		alias
			"deep_copy"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.INTEGER_64_REF"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_sign (current_: INTEGER_64_REF): INTEGER is
		external
			"IL static signature (INTEGER_64_REF): System.Int32 use Implementation.INTEGER_64_REF"
		alias
			"$$sign"
		end

	frozen ec_illegal_36_ec_illegal_36_bit_shift_left (current_: INTEGER_64_REF; n: INTEGER): INTEGER_64_REF is
		external
			"IL static signature (INTEGER_64_REF, System.Int32): INTEGER_64_REF use Implementation.INTEGER_64_REF"
		alias
			"$$bit_shift_left"
		end

feature {NONE} -- Implementation

	frozen a__infixec_illegal_32_ec_illegal_34_ec_illegal_47_ec_illegal_34_39 (arg_0: NUMERIC): NUMERIC is
		external
			"IL signature (NUMERIC): NUMERIC use Implementation.INTEGER_64_REF"
		alias
			"__infix "/"39"
		end

	finalize is
		external
			"IL signature (): System.Void use Implementation.INTEGER_64_REF"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_INTEGER_64_REF
