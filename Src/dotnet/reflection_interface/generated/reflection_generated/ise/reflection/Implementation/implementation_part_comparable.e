indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.PART_COMPARABLE"

deferred external class
	IMPLEMENTATION_PART_COMPARABLE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	PART_COMPARABLE

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PART_COMPARABLE"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.PART_COMPARABLE"
		alias
			"deep_clone"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.PART_COMPARABLE"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.PART_COMPARABLE"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.PART_COMPARABLE"
		alias
			"operating_environment"
		end

	infix ">" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.PART_COMPARABLE"
		alias
			"infix ">""
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PART_COMPARABLE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PART_COMPARABLE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.PART_COMPARABLE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PART_COMPARABLE"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.PART_COMPARABLE"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PART_COMPARABLE"
		alias
			"internal_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PART_COMPARABLE"
		alias
			"copy"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.PART_COMPARABLE"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_62_ec_illegal_34_ (current_: PART_COMPARABLE; other: PART_COMPARABLE): BOOLEAN is
		external
			"IL static signature (PART_COMPARABLE, PART_COMPARABLE): System.Boolean use Implementation.PART_COMPARABLE"
		alias
			"$$infix ">""
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.PART_COMPARABLE"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.PART_COMPARABLE"
		alias
			"equal"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.PART_COMPARABLE"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.PART_COMPARABLE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.PART_COMPARABLE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.PART_COMPARABLE"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.PART_COMPARABLE"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PART_COMPARABLE"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.PART_COMPARABLE"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.PART_COMPARABLE"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.PART_COMPARABLE"
		alias
			"deep_equal"
		end

	infix "<=" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.PART_COMPARABLE"
		alias
			"infix "<=""
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_60_ec_illegal_61_ec_illegal_34_ (current_: PART_COMPARABLE; other: PART_COMPARABLE): BOOLEAN is
		external
			"IL static signature (PART_COMPARABLE, PART_COMPARABLE): System.Boolean use Implementation.PART_COMPARABLE"
		alias
			"$$infix "<=""
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.PART_COMPARABLE"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_62_ec_illegal_61_ec_illegal_34_ (current_: PART_COMPARABLE; other: PART_COMPARABLE): BOOLEAN is
		external
			"IL static signature (PART_COMPARABLE, PART_COMPARABLE): System.Boolean use Implementation.PART_COMPARABLE"
		alias
			"$$infix ">=""
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.PART_COMPARABLE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.PART_COMPARABLE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.PART_COMPARABLE"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PART_COMPARABLE"
		alias
			"deep_copy"
		end

	infix ">=" (other: PART_COMPARABLE): BOOLEAN is
		external
			"IL signature (PART_COMPARABLE): System.Boolean use Implementation.PART_COMPARABLE"
		alias
			"infix ">=""
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PART_COMPARABLE"
		alias
			"conforms_to"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PART_COMPARABLE"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.PART_COMPARABLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_PART_COMPARABLE
