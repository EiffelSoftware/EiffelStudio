indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.BOOLEAN_REF"

external class
	IMPLEMENTATION_BOOLEAN_REF

inherit
	HASHABLE
	BOOLEAN_REF
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
			"IL creator use Implementation.BOOLEAN_REF"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_item: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"$$item"
		end

feature -- Basic Operations

	item: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"item"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.BOOLEAN_REF"
		alias
			"deep_clone"
		end

	infix "and" (other: BOOLEAN_REF): BOOLEAN is
		external
			"IL signature (BOOLEAN_REF): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"infix "and""
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.BOOLEAN_REF"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_orec_illegal_32_elseec_illegal_34_ (current_: BOOLEAN_REF; other: BOOLEAN_REF): BOOLEAN is
		external
			"IL static signature (BOOLEAN_REF, BOOLEAN_REF): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"$$infix "or else""
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.BOOLEAN_REF"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.BOOLEAN_REF"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.BOOLEAN_REF"
		alias
			"operating_environment"
		end

	to_integer: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.BOOLEAN_REF"
		alias
			"to_integer"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_to_integer (current_: BOOLEAN_REF): INTEGER is
		external
			"IL static signature (BOOLEAN_REF): System.Int32 use Implementation.BOOLEAN_REF"
		alias
			"$$to_integer"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.BOOLEAN_REF"
		alias
			"generator"
		end

	infix "implies" (other: BOOLEAN_REF): BOOLEAN is
		external
			"IL signature (BOOLEAN_REF): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"infix "implies""
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.BOOLEAN_REF"
		alias
			"internal_copy"
		end

	is_hashable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"is_hashable"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.BOOLEAN_REF"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_out (current_: BOOLEAN_REF): STRING is
		external
			"IL static signature (BOOLEAN_REF): STRING use Implementation.BOOLEAN_REF"
		alias
			"$$out"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"equal"
		end

	a_set_item (item2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.BOOLEAN_REF"
		alias
			"_set_item"
		end

	frozen ec_illegal_36_ec_illegal_36_prefixec_illegal_32_ec_illegal_34_notec_illegal_34_ (current_: BOOLEAN_REF): BOOLEAN_REF is
		external
			"IL static signature (BOOLEAN_REF): BOOLEAN_REF use Implementation.BOOLEAN_REF"
		alias
			"$$prefix "not""
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.BOOLEAN_REF"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.BOOLEAN_REF"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.BOOLEAN_REF"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.BOOLEAN_REF"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.BOOLEAN_REF"
		alias
			"default_pointer"
		end

	hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.BOOLEAN_REF"
		alias
			"hash_code"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.BOOLEAN_REF"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_orec_illegal_34_ (current_: BOOLEAN_REF; other: BOOLEAN_REF): BOOLEAN is
		external
			"IL static signature (BOOLEAN_REF, BOOLEAN_REF): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"$$infix "or""
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.BOOLEAN_REF"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_set_item (current_: BOOLEAN_REF; b: BOOLEAN) is
		external
			"IL static signature (BOOLEAN_REF, System.Boolean): System.Void use Implementation.BOOLEAN_REF"
		alias
			"$$set_item"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.BOOLEAN_REF"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_impliesec_illegal_34_ (current_: BOOLEAN_REF; other: BOOLEAN_REF): BOOLEAN is
		external
			"IL static signature (BOOLEAN_REF, BOOLEAN_REF): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"$$infix "implies""
		end

	infix "or else" (other: BOOLEAN_REF): BOOLEAN is
		external
			"IL signature (BOOLEAN_REF): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"infix "or else""
		end

	prefixec_illegal_32_ec_illegal_34_notec_illegal_34_: BOOLEAN_REF is
		external
			"IL signature (): BOOLEAN_REF use Implementation.BOOLEAN_REF"
		alias
			"prefix "not""
		end

	frozen ec_illegal_36_ec_illegal_36_hash_code (current_: BOOLEAN_REF): INTEGER is
		external
			"IL static signature (BOOLEAN_REF): System.Int32 use Implementation.BOOLEAN_REF"
		alias
			"$$hash_code"
		end

	set_item (b: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.BOOLEAN_REF"
		alias
			"set_item"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.BOOLEAN_REF"
		alias
			"generating_type"
		end

	infix "or" (other: BOOLEAN_REF): BOOLEAN is
		external
			"IL signature (BOOLEAN_REF): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"infix "or""
		end

	infix "and then" (other: BOOLEAN_REF): BOOLEAN is
		external
			"IL signature (BOOLEAN_REF): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"infix "and then""
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_xorec_illegal_34_ (current_: BOOLEAN_REF; other: BOOLEAN_REF): BOOLEAN is
		external
			"IL static signature (BOOLEAN_REF, BOOLEAN_REF): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"$$infix "xor""
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.BOOLEAN_REF"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.BOOLEAN_REF"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.BOOLEAN_REF"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_andec_illegal_34_ (current_: BOOLEAN_REF; other: BOOLEAN_REF): BOOLEAN is
		external
			"IL static signature (BOOLEAN_REF, BOOLEAN_REF): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"$$infix "and""
		end

	frozen ec_illegal_36_ec_illegal_36_is_hashable (current_: BOOLEAN_REF): BOOLEAN is
		external
			"IL static signature (BOOLEAN_REF): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"$$is_hashable"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.BOOLEAN_REF"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.BOOLEAN_REF"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_andec_illegal_32_thenec_illegal_34_ (current_: BOOLEAN_REF; other: BOOLEAN_REF): BOOLEAN is
		external
			"IL static signature (BOOLEAN_REF, BOOLEAN_REF): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"$$infix "and then""
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.BOOLEAN_REF"
		alias
			"print"
		end

	infix "xor" (other: BOOLEAN_REF): BOOLEAN is
		external
			"IL signature (BOOLEAN_REF): System.Boolean use Implementation.BOOLEAN_REF"
		alias
			"infix "xor""
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.BOOLEAN_REF"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_BOOLEAN_REF
