indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ANY"

external class
	IMPLEMENTATION_ANY

inherit
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
			"IL creator use Implementation.ANY"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ANY"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ANY"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_deep_clone (current_: ANY; other: ANY): ANY is
		external
			"IL static signature (ANY, ANY): ANY use Implementation.ANY"
		alias
			"$$deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_standard_clone (current_: ANY; other: ANY): ANY is
		external
			"IL static signature (ANY, ANY): ANY use Implementation.ANY"
		alias
			"$$standard_clone"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ANY"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ANY"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ANY"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ANY"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ANY"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_clone (current_: ANY; other: ANY): ANY is
		external
			"IL static signature (ANY, ANY): ANY use Implementation.ANY"
		alias
			"$$clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ANY"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ANY"
		alias
			"same_type"
		end

	frozen ec_illegal_36_ec_illegal_36_generating_type (current_: ANY): STRING is
		external
			"IL static signature (ANY): STRING use Implementation.ANY"
		alias
			"$$generating_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ANY"
		alias
			"generator"
		end

	frozen ec_illegal_36_ec_illegal_36_standard_equal (current_: ANY; some: ANY; other: ANY): BOOLEAN is
		external
			"IL static signature (ANY, ANY, ANY): System.Boolean use Implementation.ANY"
		alias
			"$$standard_equal"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ANY"
		alias
			"internal_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_tagged_out (current_: ANY): STRING is
		external
			"IL static signature (ANY): STRING use Implementation.ANY"
		alias
			"$$tagged_out"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ANY"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_out (current_: ANY): STRING is
		external
			"IL static signature (ANY): STRING use Implementation.ANY"
		alias
			"$$out"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_copy (current_: ANY; o: ANY) is
		external
			"IL static signature (ANY, ANY): System.Void use Implementation.ANY"
		alias
			"$$internal_copy"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ANY"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_operating_environment (current_: ANY): OPERATING_ENVIRONMENT is
		external
			"IL static signature (ANY): OPERATING_ENVIRONMENT use Implementation.ANY"
		alias
			"$$operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ANY"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ANY"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ANY"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ANY"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ANY"
		alias
			"default_pointer"
		end

	frozen ec_illegal_36_ec_illegal_36_conforms_to (current_: ANY; other: ANY): BOOLEAN is
		external
			"IL static signature (ANY, ANY): System.Boolean use Implementation.ANY"
		alias
			"$$conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_same_type (current_: ANY; other: ANY): BOOLEAN is
		external
			"IL static signature (ANY, ANY): System.Boolean use Implementation.ANY"
		alias
			"$$same_type"
		end

	frozen ec_illegal_36_ec_illegal_36_default_rescue (current_: ANY) is
		external
			"IL static signature (ANY): System.Void use Implementation.ANY"
		alias
			"$$default_rescue"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ANY"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_generator (current_: ANY): STRING is
		external
			"IL static signature (ANY): STRING use Implementation.ANY"
		alias
			"$$generator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ANY"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ANY"
		alias
			"default"
		end

	frozen ec_illegal_36_ec_illegal_36_deep_copy (current_: ANY; other: ANY) is
		external
			"IL static signature (ANY, ANY): System.Void use Implementation.ANY"
		alias
			"$$deep_copy"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ANY"
		alias
			"deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_standard_copy (current_: ANY; other: ANY) is
		external
			"IL static signature (ANY, ANY): System.Void use Implementation.ANY"
		alias
			"$$standard_copy"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ANY"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_deep_equal (current_: ANY; some: ANY; other: ANY): BOOLEAN is
		external
			"IL static signature (ANY, ANY, ANY): System.Boolean use Implementation.ANY"
		alias
			"$$deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_do_nothing (current_: ANY) is
		external
			"IL static signature (ANY): System.Void use Implementation.ANY"
		alias
			"$$do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_copy (current_: ANY; other: ANY) is
		external
			"IL static signature (ANY, ANY): System.Void use Implementation.ANY"
		alias
			"$$copy"
		end

	frozen ec_illegal_36_ec_illegal_36_equal (current_: ANY; some: ANY; other: ANY): BOOLEAN is
		external
			"IL static signature (ANY, ANY, ANY): System.Boolean use Implementation.ANY"
		alias
			"$$equal"
		end

	frozen ec_illegal_36_ec_illegal_36_io (current_: ANY): STD_FILES is
		external
			"IL static signature (ANY): STD_FILES use Implementation.ANY"
		alias
			"$$io"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ANY"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_print (current_: ANY; some: ANY) is
		external
			"IL static signature (ANY, ANY): System.Void use Implementation.ANY"
		alias
			"$$print"
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: ANY; other: ANY): BOOLEAN is
		external
			"IL static signature (ANY, ANY): System.Boolean use Implementation.ANY"
		alias
			"$$is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_default_pointer (current_: ANY): POINTER is
		external
			"IL static signature (ANY): System.IntPtr use Implementation.ANY"
		alias
			"$$default_pointer"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ANY"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ANY"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ANY"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_default_create (current_: ANY) is
		external
			"IL static signature (ANY): System.Void use Implementation.ANY"
		alias
			"$$default_create"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ANY"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ANY"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ANY"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_default (current_: ANY): ANY is
		external
			"IL static signature (ANY): ANY use Implementation.ANY"
		alias
			"$$default"
		end

	frozen ec_illegal_36_ec_illegal_36_standard_is_equal (current_: ANY; other: ANY): BOOLEAN is
		external
			"IL static signature (ANY, ANY): System.Boolean use Implementation.ANY"
		alias
			"$$standard_is_equal"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ANY"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ANY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ANY
