indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.PLATFORM"

external class
	IMPLEMENTATION_PLATFORM

inherit
	PLATFORM
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
			"IL creator use Implementation.PLATFORM"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.PLATFORM"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_double_bits (current_: PLATFORM): INTEGER is
		external
			"IL static signature (PLATFORM): System.Int32 use Implementation.PLATFORM"
		alias
			"$$double_bits"
		end

	wide_character_bytes: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"wide_character_bytes"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.PLATFORM"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_bits (current_: PLATFORM): INTEGER is
		external
			"IL static signature (PLATFORM): System.Int32 use Implementation.PLATFORM"
		alias
			"$$integer_bits"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.PLATFORM"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.PLATFORM"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PLATFORM"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PLATFORM"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_16_bytes (current_: PLATFORM): INTEGER is
		external
			"IL static signature (PLATFORM): System.Int32 use Implementation.PLATFORM"
		alias
			"$$integer_16_bytes"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.PLATFORM"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PLATFORM"
		alias
			"same_type"
		end

	character_bytes: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"character_bytes"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.PLATFORM"
		alias
			"generator"
		end

	frozen ec_illegal_36_ec_illegal_36_real_bytes (current_: PLATFORM): INTEGER is
		external
			"IL static signature (PLATFORM): System.Int32 use Implementation.PLATFORM"
		alias
			"$$real_bytes"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PLATFORM"
		alias
			"internal_copy"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.PLATFORM"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_pointer_bytes (current_: PLATFORM): INTEGER is
		external
			"IL static signature (PLATFORM): System.Int32 use Implementation.PLATFORM"
		alias
			"$$pointer_bytes"
		end

	frozen ec_illegal_36_ec_illegal_36_character_bytes (current_: PLATFORM): INTEGER is
		external
			"IL static signature (PLATFORM): System.Int32 use Implementation.PLATFORM"
		alias
			"$$character_bytes"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.PLATFORM"
		alias
			"standard_clone"
		end

	pointer_bits: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"pointer_bits"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.PLATFORM"
		alias
			"equal"
		end

	pointer_bytes: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"pointer_bytes"
		end

	integer_8_bytes: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"integer_8_bytes"
		end

	double_bytes: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"double_bytes"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.PLATFORM"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.PLATFORM"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.PLATFORM"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.PLATFORM"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.PLATFORM"
		alias
			"default_pointer"
		end

	boolean_bits: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"boolean_bits"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PLATFORM"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.PLATFORM"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.PLATFORM"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.PLATFORM"
		alias
			"deep_equal"
		end

	double_bits: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"double_bits"
		end

	integer_64_bytes: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"integer_64_bytes"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.PLATFORM"
		alias
			"generating_type"
		end

	real_bytes: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"real_bytes"
		end

	frozen ec_illegal_36_ec_illegal_36_pointer_bits (current_: PLATFORM): INTEGER is
		external
			"IL static signature (PLATFORM): System.Int32 use Implementation.PLATFORM"
		alias
			"$$pointer_bits"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_64_bytes (current_: PLATFORM): INTEGER is
		external
			"IL static signature (PLATFORM): System.Int32 use Implementation.PLATFORM"
		alias
			"$$integer_64_bytes"
		end

	character_bits: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"character_bits"
		end

	integer_bits: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"integer_bits"
		end

	real_bits: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"real_bits"
		end

	frozen ec_illegal_36_ec_illegal_36_character_bits (current_: PLATFORM): INTEGER is
		external
			"IL static signature (PLATFORM): System.Int32 use Implementation.PLATFORM"
		alias
			"$$character_bits"
		end

	integer_16_bytes: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"integer_16_bytes"
		end

	frozen ec_illegal_36_ec_illegal_36_double_bytes (current_: PLATFORM): INTEGER is
		external
			"IL static signature (PLATFORM): System.Int32 use Implementation.PLATFORM"
		alias
			"$$double_bytes"
		end

	integer_bytes: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"integer_bytes"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_8_bytes (current_: PLATFORM): INTEGER is
		external
			"IL static signature (PLATFORM): System.Int32 use Implementation.PLATFORM"
		alias
			"$$integer_8_bytes"
		end

	frozen ec_illegal_36_ec_illegal_36_real_bits (current_: PLATFORM): INTEGER is
		external
			"IL static signature (PLATFORM): System.Int32 use Implementation.PLATFORM"
		alias
			"$$real_bits"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.PLATFORM"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.PLATFORM"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_boolean_bits (current_: PLATFORM): INTEGER is
		external
			"IL static signature (PLATFORM): System.Int32 use Implementation.PLATFORM"
		alias
			"$$boolean_bits"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.PLATFORM"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_boolean_bytes (current_: PLATFORM): INTEGER is
		external
			"IL static signature (PLATFORM): System.Int32 use Implementation.PLATFORM"
		alias
			"$$boolean_bytes"
		end

	frozen ec_illegal_36_ec_illegal_36_wide_character_bytes (current_: PLATFORM): INTEGER is
		external
			"IL static signature (PLATFORM): System.Int32 use Implementation.PLATFORM"
		alias
			"$$wide_character_bytes"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PLATFORM"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PLATFORM"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PLATFORM"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_bytes (current_: PLATFORM): INTEGER is
		external
			"IL static signature (PLATFORM): System.Int32 use Implementation.PLATFORM"
		alias
			"$$integer_bytes"
		end

	boolean_bytes: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PLATFORM"
		alias
			"boolean_bytes"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PLATFORM"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.PLATFORM"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_PLATFORM
