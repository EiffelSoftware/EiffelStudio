indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.BIT_REF"

external class
	IMPLEMENTATION_BIT_REF

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	BIT_REF

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.BIT_REF"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_values: SPECIAL_INT32 is
		external
			"IL field signature :SPECIAL_INT32 use Implementation.BIT_REF"
		alias
			"$$values"
		end

	frozen ec_illegal_36_ec_illegal_36_count: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.BIT_REF"
		alias
			"$$count"
		end

feature -- Basic Operations

	item (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.BIT_REF"
		alias
			"item"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.BIT_REF"
		alias
			"deep_clone"
		end

	infix "and" (other: BIT_REF): BIT_REF is
		external
			"IL signature (BIT_REF): BIT_REF use Implementation.BIT_REF"
		alias
			"infix "and""
		end

	infix "@" (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.BIT_REF"
		alias
			"infix "@""
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.BIT_REF"
		alias
			"GetHashCode"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.BIT_REF"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.BIT_REF"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.BIT_REF"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.BIT_REF"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.BIT_REF"
		alias
			"is_equal"
		end

	infix "|" (other: BIT_REF): BIT_REF is
		external
			"IL signature (BIT_REF): BIT_REF use Implementation.BIT_REF"
		alias
			"infix "|""
		end

	count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.BIT_REF"
		alias
			"count"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.BIT_REF"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.BIT_REF"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.BIT_REF"
		alias
			"generator"
		end

	a_set_values (values2: SPECIAL_INT32) is
		external
			"IL signature (SPECIAL_INT32): System.Void use Implementation.BIT_REF"
		alias
			"_set_values"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.BIT_REF"
		alias
			"internal_copy"
		end

	values: SPECIAL_INT32 is
		external
			"IL signature (): SPECIAL_INT32 use Implementation.BIT_REF"
		alias
			"values"
		end

	infix "implies" (other: BIT_REF): BIT_REF is
		external
			"IL signature (BIT_REF): BIT_REF use Implementation.BIT_REF"
		alias
			"infix "implies""
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.BIT_REF"
		alias
			"standard_clone"
		end

	infix "#" (s: INTEGER): BIT_REF is
		external
			"IL signature (System.Int32): BIT_REF use Implementation.BIT_REF"
		alias
			"infix "#""
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.BIT_REF"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_124_ec_illegal_34_ (current_: BIT_REF; other: BIT_REF): BIT_REF is
		external
			"IL static signature (BIT_REF, BIT_REF): BIT_REF use Implementation.BIT_REF"
		alias
			"$$infix "|""
		end

	a_set_count (count2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.BIT_REF"
		alias
			"_set_count"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.BIT_REF"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.BIT_REF"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.BIT_REF"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.BIT_REF"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.BIT_REF"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.BIT_REF"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_orec_illegal_34_ (current_: BIT_REF; other: BIT_REF): BIT_REF is
		external
			"IL static signature (BIT_REF, BIT_REF): BIT_REF use Implementation.BIT_REF"
		alias
			"$$infix "or""
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.BIT_REF"
		alias
			"ToString"
		end

	infix "^" (s: INTEGER): BIT_REF is
		external
			"IL signature (System.Int32): BIT_REF use Implementation.BIT_REF"
		alias
			"infix "^""
		end

	frozen ec_illegal_36_ec_illegal_36_out (current_: BIT_REF): STRING is
		external
			"IL static signature (BIT_REF): STRING use Implementation.BIT_REF"
		alias
			"$$out"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.BIT_REF"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.BIT_REF"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.BIT_REF"
		alias
			"Equals"
		end

	make_initialized (l_area: SPECIAL_INT32; l_count: INTEGER) is
		external
			"IL signature (SPECIAL_INT32, System.Int32): System.Void use Implementation.BIT_REF"
		alias
			"make_initialized"
		end

	frozen ec_illegal_36_ec_illegal_36_prefixec_illegal_32_ec_illegal_34_notec_illegal_34_ (current_: BIT_REF): BIT_REF is
		external
			"IL static signature (BIT_REF): BIT_REF use Implementation.BIT_REF"
		alias
			"$$prefix "not""
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_impliesec_illegal_34_ (current_: BIT_REF; other: BIT_REF): BIT_REF is
		external
			"IL static signature (BIT_REF, BIT_REF): BIT_REF use Implementation.BIT_REF"
		alias
			"$$infix "implies""
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_#ec_illegal_34_ (current_: BIT_REF; s: INTEGER): BIT_REF is
		external
			"IL static signature (BIT_REF, System.Int32): BIT_REF use Implementation.BIT_REF"
		alias
			"$$infix "#""
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: BIT_REF; i: INTEGER): BOOLEAN is
		external
			"IL static signature (BIT_REF, System.Int32): System.Boolean use Implementation.BIT_REF"
		alias
			"$$item"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: BIT_REF; i: INTEGER): BOOLEAN is
		external
			"IL static signature (BIT_REF, System.Int32): System.Boolean use Implementation.BIT_REF"
		alias
			"$$infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: BIT_REF; other: BIT_REF): BOOLEAN is
		external
			"IL static signature (BIT_REF, BIT_REF): System.Boolean use Implementation.BIT_REF"
		alias
			"$$is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_make_initialized (current_: BIT_REF; l_area: SPECIAL_INT32; l_count: INTEGER) is
		external
			"IL static signature (BIT_REF, SPECIAL_INT32, System.Int32): System.Void use Implementation.BIT_REF"
		alias
			"$$make_initialized"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: BIT_REF; value: BOOLEAN; i: INTEGER) is
		external
			"IL static signature (BIT_REF, System.Boolean, System.Int32): System.Void use Implementation.BIT_REF"
		alias
			"$$put"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.BIT_REF"
		alias
			"generating_type"
		end

	infix "or" (other: BIT_REF): BIT_REF is
		external
			"IL signature (BIT_REF): BIT_REF use Implementation.BIT_REF"
		alias
			"infix "or""
		end

	prefixec_illegal_32_ec_illegal_34_notec_illegal_34_: BIT_REF is
		external
			"IL signature (): BIT_REF use Implementation.BIT_REF"
		alias
			"prefix "not""
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_xorec_illegal_34_ (current_: BIT_REF; other: BIT_REF): BIT_REF is
		external
			"IL static signature (BIT_REF, BIT_REF): BIT_REF use Implementation.BIT_REF"
		alias
			"$$infix "xor""
		end

	put (value: BOOLEAN; i: INTEGER) is
		external
			"IL signature (System.Boolean, System.Int32): System.Void use Implementation.BIT_REF"
		alias
			"put"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.BIT_REF"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.BIT_REF"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.BIT_REF"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_andec_illegal_34_ (current_: BIT_REF; other: BIT_REF): BIT_REF is
		external
			"IL static signature (BIT_REF, BIT_REF): BIT_REF use Implementation.BIT_REF"
		alias
			"$$infix "and""
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.BIT_REF"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.BIT_REF"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.BIT_REF"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: BIT_REF; n: INTEGER) is
		external
			"IL static signature (BIT_REF, System.Int32): System.Void use Implementation.BIT_REF"
		alias
			"$$make"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_94_ec_illegal_34_ (current_: BIT_REF; s: INTEGER): BIT_REF is
		external
			"IL static signature (BIT_REF, System.Int32): BIT_REF use Implementation.BIT_REF"
		alias
			"$$infix "^""
		end

	make (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.BIT_REF"
		alias
			"make"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.BIT_REF"
		alias
			"print"
		end

	infix "xor" (other: BIT_REF): BIT_REF is
		external
			"IL signature (BIT_REF): BIT_REF use Implementation.BIT_REF"
		alias
			"infix "xor""
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.BIT_REF"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_BIT_REF
