indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.CHARACTER_REF"

external class
	IMPLEMENTATION_CHARACTER_REF

inherit
	CHARACTER_REF
	HASHABLE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	COMPARABLE
	PART_COMPARABLE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.CHARACTER_REF"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_item: CHARACTER is
		external
			"IL field signature :System.Char use Implementation.CHARACTER_REF"
		alias
			"$$item"
		end

feature -- Basic Operations

	is_alpha: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"is_alpha"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.CHARACTER_REF"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CHARACTER_REF"
		alias
			"____class_name"
		end

	frozen ec_illegal_36_ec_illegal_36_chis_upper (current_: CHARACTER_REF; c: CHARACTER): BOOLEAN is
		external
			"IL static signature (CHARACTER_REF, System.Char): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"$$chis_upper"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.CHARACTER_REF"
		alias
			"default_create"
		end

	infix "-" (decr: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.CHARACTER_REF"
		alias
			"infix "-""
		end

	chis_digit (c: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"chis_digit"
		end

	ec_illegal_34__in_infix " (incr: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.CHARACTER_REF"
		alias
			"infix "+""
		end

	infix "|-|" (other: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use Implementation.CHARACTER_REF"
		alias
			"infix "|-|""
		end

	max (other: COMPARABLE): COMPARABLE is
		external
			"IL signature (COMPARABLE): COMPARABLE use Implementation.CHARACTER_REF"
		alias
			"max"
		end

	frozen ec_illegal_36_ec_illegal_36_is_hashable (current_: CHARACTER_REF): BOOLEAN is
		external
			"IL static signature (CHARACTER_REF): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"$$is_hashable"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CHARACTER_REF"
		alias
			"ToString"
		end

	infix ">" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"infix ">""
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.CHARACTER_REF"
		alias
			"generating_type"
		end

	c_outc (c: CHARACTER): STRING is
		external
			"IL signature (System.Char): STRING use Implementation.CHARACTER_REF"
		alias
			"c_outc"
		end

	chupper (c: CHARACTER): CHARACTER is
		external
			"IL signature (System.Char): System.Char use Implementation.CHARACTER_REF"
		alias
			"chupper"
		end

	is_digit: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"is_digit"
		end

	next: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.CHARACTER_REF"
		alias
			"next"
		end

	min (other: COMPARABLE): COMPARABLE is
		external
			"IL signature (COMPARABLE): COMPARABLE use Implementation.CHARACTER_REF"
		alias
			"min"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.CHARACTER_REF"
		alias
			"out"
		end

	infix "<=" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"infix "<=""
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_45_ec_illegal_34_ (current_: CHARACTER_REF; decr: INTEGER): CHARACTER is
		external
			"IL static signature (CHARACTER_REF, System.Int32): System.Char use Implementation.CHARACTER_REF"
		alias
			"$$infix "-""
		end

	upper: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.CHARACTER_REF"
		alias
			"upper"
		end

	hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CHARACTER_REF"
		alias
			"hash_code"
		end

	frozen ec_illegal_36_ec_illegal_36_out (current_: CHARACTER_REF): STRING is
		external
			"IL static signature (CHARACTER_REF): STRING use Implementation.CHARACTER_REF"
		alias
			"$$out"
		end

	frozen ec_illegal_36_ec_illegal_36_next (current_: CHARACTER_REF): CHARACTER is
		external
			"IL static signature (CHARACTER_REF): System.Char use Implementation.CHARACTER_REF"
		alias
			"$$next"
		end

	frozen ec_illegal_36_ec_illegal_36_upper (current_: CHARACTER_REF): CHARACTER is
		external
			"IL static signature (CHARACTER_REF): System.Char use Implementation.CHARACTER_REF"
		alias
			"$$upper"
		end

	frozen ec_illegal_36_ec_illegal_36_previous (current_: CHARACTER_REF): CHARACTER is
		external
			"IL static signature (CHARACTER_REF): System.Char use Implementation.CHARACTER_REF"
		alias
			"$$previous"
		end

	frozen ec_illegal_36_ec_illegal_36_min_value (current_: CHARACTER_REF): INTEGER is
		external
			"IL static signature (CHARACTER_REF): System.Int32 use Implementation.CHARACTER_REF"
		alias
			"$$min_value"
		end

	is_upper: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"is_upper"
		end

	chis_upper (c: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"chis_upper"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"conforms_to"
		end

	infix ">=" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"infix ">=""
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.CHARACTER_REF"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_lower (current_: CHARACTER_REF): CHARACTER is
		external
			"IL static signature (CHARACTER_REF): System.Char use Implementation.CHARACTER_REF"
		alias
			"$$lower"
		end

	frozen ec_illegal_36_ec_illegal_36_chis_alpha (current_: CHARACTER_REF; c: CHARACTER): BOOLEAN is
		external
			"IL static signature (CHARACTER_REF, System.Char): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"$$chis_alpha"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.CHARACTER_REF"
		alias
			"tagged_out"
		end

	is_lower: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"is_lower"
		end

	chis_alpha (c: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"chis_alpha"
		end

	chlower (c: CHARACTER): CHARACTER is
		external
			"IL signature (System.Char): System.Char use Implementation.CHARACTER_REF"
		alias
			"chlower"
		end

	min_value: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CHARACTER_REF"
		alias
			"min_value"
		end

	set_item (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CHARACTER_REF"
		alias
			"set_item"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"same_type"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.CHARACTER_REF"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_chupper (current_: CHARACTER_REF; c: CHARACTER): CHARACTER is
		external
			"IL static signature (CHARACTER_REF, System.Char): System.Char use Implementation.CHARACTER_REF"
		alias
			"$$chupper"
		end

	chconv (i: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.CHARACTER_REF"
		alias
			"chconv"
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: CHARACTER_REF; other: CHARACTER_REF): BOOLEAN is
		external
			"IL static signature (CHARACTER_REF, CHARACTER_REF): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"$$is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_is_alpha (current_: CHARACTER_REF): BOOLEAN is
		external
			"IL static signature (CHARACTER_REF): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"$$is_alpha"
		end

	frozen ec_illegal_36_ec_illegal_36_max_value (current_: CHARACTER_REF): INTEGER is
		external
			"IL static signature (CHARACTER_REF): System.Int32 use Implementation.CHARACTER_REF"
		alias
			"$$max_value"
		end

	frozen ec_illegal_36_ec_illegal_36_is_upper (current_: CHARACTER_REF): BOOLEAN is
		external
			"IL static signature (CHARACTER_REF): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"$$is_upper"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"standard_is_equal"
		end

	three_way_comparison (other: COMPARABLE): INTEGER is
		external
			"IL signature (COMPARABLE): System.Int32 use Implementation.CHARACTER_REF"
		alias
			"three_way_comparison"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHARACTER_REF"
		alias
			"copy"
		end

	code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CHARACTER_REF"
		alias
			"code"
		end

	is_hashable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"is_hashable"
		end

	item: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.CHARACTER_REF"
		alias
			"item"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CHARACTER_REF"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.CHARACTER_REF"
		alias
			"default"
		end

	frozen ec_illegal_36_ec_illegal_36_chcode (current_: CHARACTER_REF; c: CHARACTER): INTEGER is
		external
			"IL static signature (CHARACTER_REF, System.Char): System.Int32 use Implementation.CHARACTER_REF"
		alias
			"$$chcode"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_is_digit (current_: CHARACTER_REF): BOOLEAN is
		external
			"IL static signature (CHARACTER_REF): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"$$is_digit"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHARACTER_REF"
		alias
			"standard_copy"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHARACTER_REF"
		alias
			"print"
		end

	frozen ec_illegal_36_ec_illegal_36_code (current_: CHARACTER_REF): INTEGER is
		external
			"IL static signature (CHARACTER_REF): System.Int32 use Implementation.CHARACTER_REF"
		alias
			"$$code"
		end

	frozen ec_illegal_36_ec_illegal_36_chlower (current_: CHARACTER_REF; c: CHARACTER): CHARACTER is
		external
			"IL static signature (CHARACTER_REF, System.Char): System.Char use Implementation.CHARACTER_REF"
		alias
			"$$chlower"
		end

	frozen ec_illegal_36_ec_illegal_36_c_outc (current_: CHARACTER_REF; c: CHARACTER): STRING is
		external
			"IL static signature (CHARACTER_REF, System.Char): STRING use Implementation.CHARACTER_REF"
		alias
			"$$c_outc"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"equal"
		end

	frozen ec_illegal_34__in_ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ (current_: CHARACTER_REF; incr: INTEGER): CHARACTER is
		external
			"IL static signature (CHARACTER_REF, System.Int32): System.Char use Implementation.CHARACTER_REF"
		alias
			"$$infix "+""
		end

	frozen ec_illegal_36_ec_illegal_36_chis_lower (current_: CHARACTER_REF; c: CHARACTER): BOOLEAN is
		external
			"IL static signature (CHARACTER_REF, System.Char): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"$$chis_lower"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHARACTER_REF"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"standard_equal"
		end

	infix "<" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"infix "<""
		end

	max_value: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CHARACTER_REF"
		alias
			"max_value"
		end

	lower: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.CHARACTER_REF"
		alias
			"lower"
		end

	previous: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.CHARACTER_REF"
		alias
			"previous"
		end

	frozen ec_illegal_36_ec_illegal_36_three_way_comparison (current_: CHARACTER_REF; other: CHARACTER_REF): INTEGER is
		external
			"IL static signature (CHARACTER_REF, CHARACTER_REF): System.Int32 use Implementation.CHARACTER_REF"
		alias
			"$$three_way_comparison"
		end

	chis_lower (c: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"chis_lower"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CHARACTER_REF"
		alias
			"GetHashCode"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_chconv (current_: CHARACTER_REF; i: INTEGER): CHARACTER is
		external
			"IL static signature (CHARACTER_REF, System.Int32): System.Char use Implementation.CHARACTER_REF"
		alias
			"$$chconv"
		end

	frozen ec_illegal_36_ec_illegal_36_is_lower (current_: CHARACTER_REF): BOOLEAN is
		external
			"IL static signature (CHARACTER_REF): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"$$is_lower"
		end

	chcode (c: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use Implementation.CHARACTER_REF"
		alias
			"chcode"
		end

	a_set_item (item2: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CHARACTER_REF"
		alias
			"_set_item"
		end

	frozen ec_illegal_36_ec_illegal_36_set_item (current_: CHARACTER_REF; c: CHARACTER) is
		external
			"IL static signature (CHARACTER_REF, System.Char): System.Void use Implementation.CHARACTER_REF"
		alias
			"$$set_item"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.CHARACTER_REF"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.CHARACTER_REF"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.CHARACTER_REF"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHARACTER_REF"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHARACTER_REF"
		alias
			"internal_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_124_ec_illegal_45_ec_illegal_124_ec_illegal_34_ (current_: CHARACTER_REF; other: CHARACTER): INTEGER is
		external
			"IL static signature (CHARACTER_REF, System.Char): System.Int32 use Implementation.CHARACTER_REF"
		alias
			"$$infix "|-|""
		end

	frozen ec_illegal_36_ec_illegal_36_chis_digit (current_: CHARACTER_REF; c: CHARACTER): BOOLEAN is
		external
			"IL static signature (CHARACTER_REF, System.Char): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"$$chis_digit"
		end

	frozen ec_illegal_36_ec_illegal_36_hash_code (current_: CHARACTER_REF): INTEGER is
		external
			"IL static signature (CHARACTER_REF): System.Int32 use Implementation.CHARACTER_REF"
		alias
			"$$hash_code"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CHARACTER_REF"
		alias
			"deep_copy"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CHARACTER_REF"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_60_ec_illegal_34_ (current_: CHARACTER_REF; other: CHARACTER_REF): BOOLEAN is
		external
			"IL static signature (CHARACTER_REF, CHARACTER_REF): System.Boolean use Implementation.CHARACTER_REF"
		alias
			"$$infix "<""
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.CHARACTER_REF"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_CHARACTER_REF
