indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.GENERIC_DERIVATION"

external class
	IMPLEMENTATION_GENERIC_DERIVATION

inherit
	GENERIC_DERIVATION
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
			"IL creator use Implementation.GENERIC_DERIVATION"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_generic_types: ARRAY_ANY is
		external
			"IL field signature :ARRAY_ANY use Implementation.GENERIC_DERIVATION"
		alias
			"$$generic_types"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.GENERIC_DERIVATION"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.GENERIC_DERIVATION"
		alias
			"deep_clone"
		end

	generic_types: ARRAY_ANY is
		external
			"IL signature (): ARRAY_ANY use Implementation.GENERIC_DERIVATION"
		alias
			"generic_types"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.GENERIC_DERIVATION"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.GENERIC_DERIVATION"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.GENERIC_DERIVATION"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.GENERIC_DERIVATION"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.GENERIC_DERIVATION"
		alias
			"is_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.GENERIC_DERIVATION"
		alias
			"same_type"
		end

	add_derivation_type (a_type: SIGNATURE_TYPE) is
		external
			"IL signature (SIGNATURE_TYPE): System.Void use Implementation.GENERIC_DERIVATION"
		alias
			"add_derivation_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.GENERIC_DERIVATION"
		alias
			"generator"
		end

	frozen ec_illegal_36_ec_illegal_36_add_derivation_type (current_: GENERIC_DERIVATION; a_type: SIGNATURE_TYPE) is
		external
			"IL static signature (GENERIC_DERIVATION, SIGNATURE_TYPE): System.Void use Implementation.GENERIC_DERIVATION"
		alias
			"$$add_derivation_type"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GENERIC_DERIVATION"
		alias
			"internal_copy"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.GENERIC_DERIVATION"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.GENERIC_DERIVATION"
		alias
			"equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.GENERIC_DERIVATION"
		alias
			"standard_equal"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.GENERIC_DERIVATION"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.GENERIC_DERIVATION"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.GENERIC_DERIVATION"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.GENERIC_DERIVATION"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.GENERIC_DERIVATION"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GENERIC_DERIVATION"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.GENERIC_DERIVATION"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.GENERIC_DERIVATION"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.GENERIC_DERIVATION"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.GENERIC_DERIVATION"
		alias
			"Equals"
		end

	a_set_generic_types (generic_types2: ARRAY_ANY) is
		external
			"IL signature (ARRAY_ANY): System.Void use Implementation.GENERIC_DERIVATION"
		alias
			"_set_generic_types"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.GENERIC_DERIVATION"
		alias
			"generating_type"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.GENERIC_DERIVATION"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.GENERIC_DERIVATION"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.GENERIC_DERIVATION"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GENERIC_DERIVATION"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GENERIC_DERIVATION"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.GENERIC_DERIVATION"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: GENERIC_DERIVATION; derivation_count: INTEGER) is
		external
			"IL static signature (GENERIC_DERIVATION, System.Int32): System.Void use Implementation.GENERIC_DERIVATION"
		alias
			"$$make"
		end

	make (derivation_count: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.GENERIC_DERIVATION"
		alias
			"make"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.GENERIC_DERIVATION"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.GENERIC_DERIVATION"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_GENERIC_DERIVATION
