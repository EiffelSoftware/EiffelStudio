indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.COMPARABLE"

deferred external class
	IMPLEMENTATION_COMPARABLE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	COMPARABLE
	PART_COMPARABLE

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.COMPARABLE"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.COMPARABLE"
		alias
			"deep_clone"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.COMPARABLE"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.COMPARABLE"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.COMPARABLE"
		alias
			"operating_environment"
		end

	infix ">" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.COMPARABLE"
		alias
			"infix ">""
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COMPARABLE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COMPARABLE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.COMPARABLE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COMPARABLE"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.COMPARABLE"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COMPARABLE"
		alias
			"internal_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COMPARABLE"
		alias
			"copy"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.COMPARABLE"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_62_ec_illegal_34_ (current_: COMPARABLE; other: COMPARABLE): BOOLEAN is
		external
			"IL static signature (COMPARABLE, COMPARABLE): System.Boolean use Implementation.COMPARABLE"
		alias
			"$$infix ">""
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.COMPARABLE"
		alias
			"standard_clone"
		end

	min (other: COMPARABLE): COMPARABLE is
		external
			"IL signature (COMPARABLE): COMPARABLE use Implementation.COMPARABLE"
		alias
			"min"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.COMPARABLE"
		alias
			"equal"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.COMPARABLE"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.COMPARABLE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.COMPARABLE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.COMPARABLE"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.COMPARABLE"
		alias
			"default_pointer"
		end

	three_way_comparison (other: COMPARABLE): INTEGER is
		external
			"IL signature (COMPARABLE): System.Int32 use Implementation.COMPARABLE"
		alias
			"three_way_comparison"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COMPARABLE"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.COMPARABLE"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.COMPARABLE"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.COMPARABLE"
		alias
			"deep_equal"
		end

	max (other: COMPARABLE): COMPARABLE is
		external
			"IL signature (COMPARABLE): COMPARABLE use Implementation.COMPARABLE"
		alias
			"max"
		end

	infix "<=" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.COMPARABLE"
		alias
			"infix "<=""
		end

	frozen ec_illegal_36_ec_illegal_36_min (current_: COMPARABLE; other: COMPARABLE): COMPARABLE is
		external
			"IL static signature (COMPARABLE, COMPARABLE): COMPARABLE use Implementation.COMPARABLE"
		alias
			"$$min"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_60_ec_illegal_61_ec_illegal_34_ (current_: COMPARABLE; other: COMPARABLE): BOOLEAN is
		external
			"IL static signature (COMPARABLE, COMPARABLE): System.Boolean use Implementation.COMPARABLE"
		alias
			"$$infix "<=""
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.COMPARABLE"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: COMPARABLE; other: COMPARABLE): BOOLEAN is
		external
			"IL static signature (COMPARABLE, COMPARABLE): System.Boolean use Implementation.COMPARABLE"
		alias
			"$$is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_62_ec_illegal_61_ec_illegal_34_ (current_: COMPARABLE; other: COMPARABLE): BOOLEAN is
		external
			"IL static signature (COMPARABLE, COMPARABLE): System.Boolean use Implementation.COMPARABLE"
		alias
			"$$infix ">=""
		end

	frozen ec_illegal_36_ec_illegal_36_max (current_: COMPARABLE; other: COMPARABLE): COMPARABLE is
		external
			"IL static signature (COMPARABLE, COMPARABLE): COMPARABLE use Implementation.COMPARABLE"
		alias
			"$$max"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.COMPARABLE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.COMPARABLE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.COMPARABLE"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COMPARABLE"
		alias
			"deep_copy"
		end

	infix ">=" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.COMPARABLE"
		alias
			"infix ">=""
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COMPARABLE"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_three_way_comparison (current_: COMPARABLE; other: COMPARABLE): INTEGER is
		external
			"IL static signature (COMPARABLE, COMPARABLE): System.Int32 use Implementation.COMPARABLE"
		alias
			"$$three_way_comparison"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COMPARABLE"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.COMPARABLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_COMPARABLE
