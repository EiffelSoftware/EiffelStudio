indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.DOUBLE_REF"

external class
	IMPLEMENTATION_DOUBLE_REF

inherit
	HASHABLE
	DOUBLE_REF
		rename
			debug_output as out_
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
			debug_output as out_
		end
	PART_COMPARABLE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.DOUBLE_REF"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_item: DOUBLE is
		external
			"IL field signature :System.Double use Implementation.DOUBLE_REF"
		alias
			"$$item"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.DOUBLE_REF"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DOUBLE_REF"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.DOUBLE_REF"
		alias
			"default_create"
		end

	infix "-" (other: NUMERIC): NUMERIC is
		external
			"IL signature (NUMERIC): NUMERIC use Implementation.DOUBLE_REF"
		alias
			"infix "-""
		end

	frozen ec_illegal_34__in_ec_illegal_36_ec_illegal_36_prefixec_illegal_32_ec_illegal_34_ (current_: DOUBLE_REF): DOUBLE_REF is
		external
			"IL static signature (DOUBLE_REF): DOUBLE_REF use Implementation.DOUBLE_REF"
		alias
			"$$prefix "+""
		end

	exponentiable (other: NUMERIC): BOOLEAN is
		external
			"IL signature (NUMERIC): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"exponentiable"
		end

	ec_illegal_34__in_prefixec_illegal_32_ec_illegal_34_: NUMERIC is
		external
			"IL signature (): NUMERIC use Implementation.DOUBLE_REF"
		alias
			"prefix "+""
		end

	ec_illegal_34__in_infix " (other: NUMERIC): NUMERIC is
		external
			"IL signature (NUMERIC): NUMERIC use Implementation.DOUBLE_REF"
		alias
			"infix "+""
		end

	frozen ec_illegal_36_ec_illegal_36_divisible (current_: DOUBLE_REF; other: DOUBLE_REF): BOOLEAN is
		external
			"IL static signature (DOUBLE_REF, DOUBLE_REF): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"$$divisible"
		end

	infix "^" (other: NUMERIC): DOUBLE is
		external
			"IL signature (NUMERIC): System.Double use Implementation.DOUBLE_REF"
		alias
			"infix "^""
		end

	max (other: COMPARABLE): COMPARABLE is
		external
			"IL signature (COMPARABLE): COMPARABLE use Implementation.DOUBLE_REF"
		alias
			"max"
		end

	truncated_to_integer: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DOUBLE_REF"
		alias
			"truncated_to_integer"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DOUBLE_REF"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_47_ec_illegal_34_ (current_: DOUBLE_REF; other: DOUBLE_REF): DOUBLE_REF is
		external
			"IL static signature (DOUBLE_REF, DOUBLE_REF): DOUBLE_REF use Implementation.DOUBLE_REF"
		alias
			"$$infix "/""
		end

	infix ">" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"infix ">""
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.DOUBLE_REF"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_floor (current_: DOUBLE_REF): INTEGER is
		external
			"IL static signature (DOUBLE_REF): System.Int32 use Implementation.DOUBLE_REF"
		alias
			"$$floor"
		end

	frozen ec_illegal_36_ec_illegal_36_abs (current_: DOUBLE_REF): DOUBLE is
		external
			"IL static signature (DOUBLE_REF): System.Double use Implementation.DOUBLE_REF"
		alias
			"$$abs"
		end

	item: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.DOUBLE_REF"
		alias
			"item"
		end

	min (other: COMPARABLE): COMPARABLE is
		external
			"IL signature (COMPARABLE): COMPARABLE use Implementation.DOUBLE_REF"
		alias
			"min"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.DOUBLE_REF"
		alias
			"out"
		end

	rounded: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DOUBLE_REF"
		alias
			"rounded"
		end

	prefixec_illegal_32_ec_illegal_34_ec_illegal_45_ec_illegal_34_: NUMERIC is
		external
			"IL signature (): NUMERIC use Implementation.DOUBLE_REF"
		alias
			"prefix "-""
		end

	infix "<=" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"infix "<=""
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_45_ec_illegal_34_ (current_: DOUBLE_REF; other: DOUBLE_REF): DOUBLE_REF is
		external
			"IL static signature (DOUBLE_REF, DOUBLE_REF): DOUBLE_REF use Implementation.DOUBLE_REF"
		alias
			"$$infix "-""
		end

	hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DOUBLE_REF"
		alias
			"hash_code"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DOUBLE_REF"
		alias
			"internal_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_out (current_: DOUBLE_REF): STRING is
		external
			"IL static signature (DOUBLE_REF): STRING use Implementation.DOUBLE_REF"
		alias
			"$$out"
		end

	infix "*" (other: NUMERIC): NUMERIC is
		external
			"IL signature (NUMERIC): NUMERIC use Implementation.DOUBLE_REF"
		alias
			"infix "*""
		end

	frozen ec_illegal_36_ec_illegal_36_truncated_to_integer (current_: DOUBLE_REF): INTEGER is
		external
			"IL static signature (DOUBLE_REF): System.Int32 use Implementation.DOUBLE_REF"
		alias
			"$$truncated_to_integer"
		end

	infix "/" (other: NUMERIC): NUMERIC is
		external
			"IL signature (NUMERIC): NUMERIC use Implementation.DOUBLE_REF"
		alias
			"infix "/""
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"conforms_to"
		end

	infix ">=" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"infix ">=""
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.DOUBLE_REF"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_abs_ref (current_: DOUBLE_REF): DOUBLE_REF is
		external
			"IL static signature (DOUBLE_REF): DOUBLE_REF use Implementation.DOUBLE_REF"
		alias
			"$$abs_ref"
		end

	frozen ec_illegal_36_ec_illegal_36_one (current_: DOUBLE_REF): DOUBLE_REF is
		external
			"IL static signature (DOUBLE_REF): DOUBLE_REF use Implementation.DOUBLE_REF"
		alias
			"$$one"
		end

	frozen ec_illegal_36_ec_illegal_36_exponentiable (current_: DOUBLE_REF; other: NUMERIC): BOOLEAN is
		external
			"IL static signature (DOUBLE_REF, NUMERIC): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"$$exponentiable"
		end

	divisible (other: NUMERIC): BOOLEAN is
		external
			"IL signature (NUMERIC): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"divisible"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.DOUBLE_REF"
		alias
			"tagged_out"
		end

	zero: NUMERIC is
		external
			"IL signature (): NUMERIC use Implementation.DOUBLE_REF"
		alias
			"zero"
		end

	truncated_to_real: REAL is
		external
			"IL signature (): System.Single use Implementation.DOUBLE_REF"
		alias
			"truncated_to_real"
		end

	set_item (d: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.DOUBLE_REF"
		alias
			"set_item"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"same_type"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.DOUBLE_REF"
		alias
			"do_nothing"
		end

	abs: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.DOUBLE_REF"
		alias
			"abs"
		end

	frozen ec_illegal_36_ec_illegal_36_is_hashable (current_: DOUBLE_REF): BOOLEAN is
		external
			"IL static signature (DOUBLE_REF): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"$$is_hashable"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_94_ec_illegal_34_ (current_: DOUBLE_REF; other: NUMERIC): DOUBLE is
		external
			"IL static signature (DOUBLE_REF, NUMERIC): System.Double use Implementation.DOUBLE_REF"
		alias
			"$$infix "^""
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_42_ec_illegal_34_ (current_: DOUBLE_REF; other: DOUBLE_REF): DOUBLE_REF is
		external
			"IL static signature (DOUBLE_REF, DOUBLE_REF): DOUBLE_REF use Implementation.DOUBLE_REF"
		alias
			"$$infix "*""
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: DOUBLE_REF; other: DOUBLE_REF): BOOLEAN is
		external
			"IL static signature (DOUBLE_REF, DOUBLE_REF): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"$$is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_zero (current_: DOUBLE_REF): DOUBLE_REF is
		external
			"IL static signature (DOUBLE_REF): DOUBLE_REF use Implementation.DOUBLE_REF"
		alias
			"$$zero"
		end

	frozen ec_illegal_36_ec_illegal_36_ceiling (current_: DOUBLE_REF): INTEGER is
		external
			"IL static signature (DOUBLE_REF): System.Int32 use Implementation.DOUBLE_REF"
		alias
			"$$ceiling"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"standard_is_equal"
		end

	three_way_comparison (other: COMPARABLE): INTEGER is
		external
			"IL signature (COMPARABLE): System.Int32 use Implementation.DOUBLE_REF"
		alias
			"three_way_comparison"
		end

	abs_ref: DOUBLE_REF is
		external
			"IL signature (): DOUBLE_REF use Implementation.DOUBLE_REF"
		alias
			"abs_ref"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"equal"
		end

	one: NUMERIC is
		external
			"IL signature (): NUMERIC use Implementation.DOUBLE_REF"
		alias
			"one"
		end

	is_hashable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"is_hashable"
		end

	floor: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DOUBLE_REF"
		alias
			"floor"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.DOUBLE_REF"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.DOUBLE_REF"
		alias
			"default"
		end

	frozen ec_illegal_36_ec_illegal_36_prefixec_illegal_32_ec_illegal_34_ec_illegal_45_ec_illegal_34_ (current_: DOUBLE_REF): DOUBLE_REF is
		external
			"IL static signature (DOUBLE_REF): DOUBLE_REF use Implementation.DOUBLE_REF"
		alias
			"$$prefix "-""
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"is_equal"
		end

	ceiling: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DOUBLE_REF"
		alias
			"ceiling"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DOUBLE_REF"
		alias
			"print"
		end

	frozen ec_illegal_36_ec_illegal_36_three_way_comparison (current_: DOUBLE_REF; other: DOUBLE_REF): INTEGER is
		external
			"IL static signature (DOUBLE_REF, DOUBLE_REF): System.Int32 use Implementation.DOUBLE_REF"
		alias
			"$$three_way_comparison"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.DOUBLE_REF"
		alias
			"generator"
		end

	frozen ec_illegal_34__in_ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ (current_: DOUBLE_REF; other: DOUBLE_REF): DOUBLE_REF is
		external
			"IL static signature (DOUBLE_REF, DOUBLE_REF): DOUBLE_REF use Implementation.DOUBLE_REF"
		alias
			"$$infix "+""
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DOUBLE_REF"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"standard_equal"
		end

	infix "<" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"infix "<""
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DOUBLE_REF"
		alias
			"standard_copy"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DOUBLE_REF"
		alias
			"GetHashCode"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"deep_equal"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DOUBLE_REF"
		alias
			"copy"
		end

	sign: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DOUBLE_REF"
		alias
			"sign"
		end

	a_set_item (item2: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.DOUBLE_REF"
		alias
			"_set_item"
		end

	frozen ec_illegal_36_ec_illegal_36_set_item (current_: DOUBLE_REF; d: DOUBLE) is
		external
			"IL static signature (DOUBLE_REF, System.Double): System.Void use Implementation.DOUBLE_REF"
		alias
			"$$set_item"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.DOUBLE_REF"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.DOUBLE_REF"
		alias
			"internal_clone"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DOUBLE_REF"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_truncated_to_real (current_: DOUBLE_REF): REAL is
		external
			"IL static signature (DOUBLE_REF): System.Single use Implementation.DOUBLE_REF"
		alias
			"$$truncated_to_real"
		end

	frozen ec_illegal_36_ec_illegal_36_rounded (current_: DOUBLE_REF): INTEGER is
		external
			"IL static signature (DOUBLE_REF): System.Int32 use Implementation.DOUBLE_REF"
		alias
			"$$rounded"
		end

	frozen ec_illegal_36_ec_illegal_36_hash_code (current_: DOUBLE_REF): INTEGER is
		external
			"IL static signature (DOUBLE_REF): System.Int32 use Implementation.DOUBLE_REF"
		alias
			"$$hash_code"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DOUBLE_REF"
		alias
			"deep_copy"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DOUBLE_REF"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_sign (current_: DOUBLE_REF): INTEGER is
		external
			"IL static signature (DOUBLE_REF): System.Int32 use Implementation.DOUBLE_REF"
		alias
			"$$sign"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_60_ec_illegal_34_ (current_: DOUBLE_REF; other: DOUBLE_REF): BOOLEAN is
		external
			"IL static signature (DOUBLE_REF, DOUBLE_REF): System.Boolean use Implementation.DOUBLE_REF"
		alias
			"$$infix "<""
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.DOUBLE_REF"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_DOUBLE_REF
