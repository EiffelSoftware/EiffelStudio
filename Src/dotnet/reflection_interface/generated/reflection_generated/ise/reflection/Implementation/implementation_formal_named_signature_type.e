indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.FORMAL_NAMED_SIGNATURE_TYPE"

external class
	IMPLEMENTATION_FORMAL_NAMED_SIGNATURE_TYPE

inherit
	NAMED_SIGNATURE_TYPE_INTERFACE
	FORMAL_SIGNATURE_TYPE
	SIGNATURE_TYPE_INTERFACE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SIGNATURE_TYPE
	FORMAL_NAMED_SIGNATURE_TYPE

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_internal_eiffel_name: STRING is
		external
			"IL field signature :STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"$$internal_eiffel_name"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_type_full_external_name: STRING is
		external
			"IL field signature :STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"$$internal_type_full_external_name"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_type_eiffel_name: STRING is
		external
			"IL field signature :STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"$$internal_type_eiffel_name"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_external_name: STRING is
		external
			"IL field signature :STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"$$internal_external_name"
		end

	frozen ec_illegal_36_ec_illegal_36_generic_parameter_index: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"$$generic_parameter_index"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"GetHashCode"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"standard_clone"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"deep_clone"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"generator"
		end

	type_full_external_name: STRING is
		external
			"IL signature (): STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"type_full_external_name"
		end

	a_set_generic_parameter_index (generic_parameter_index2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"_set_generic_parameter_index"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"internal_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"copy"
		end

	set_eiffel_name (a_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"set_eiffel_name"
		end

	a_set_internal_type_full_external_name (internal_type_full_external_name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"_set_internal_type_full_external_name"
		end

	set_type_full_external_name (a_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"set_type_full_external_name"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"equal"
		end

	a_set_internal_external_name (internal_external_name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"_set_internal_external_name"
		end

	type_eiffel_name: STRING is
		external
			"IL signature (): STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"type_eiffel_name"
		end

	internal_type_eiffel_name: STRING is
		external
			"IL signature (): STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"internal_type_eiffel_name"
		end

	set_generic_parameter_index (an_index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"set_generic_parameter_index"
		end

	a_set_internal_eiffel_name (internal_eiffel_name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"_set_internal_eiffel_name"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"____class_name"
		end

	set_type_eiffel_name (a_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"set_type_eiffel_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"default_rescue"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"make"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"default_pointer"
		end

	internal_eiffel_name: STRING is
		external
			"IL signature (): STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"internal_eiffel_name"
		end

	eiffel_name: STRING is
		external
			"IL signature (): STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"eiffel_name"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"deep_equal"
		end

	generic_parameter_index: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"generic_parameter_index"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_external_name (current_: FORMAL_NAMED_SIGNATURE_TYPE): STRING is
		external
			"IL static signature (FORMAL_NAMED_SIGNATURE_TYPE): STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"$$external_name"
		end

	internal_external_name: STRING is
		external
			"IL signature (): STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"internal_external_name"
		end

	frozen ec_illegal_36_ec_illegal_36_set_eiffel_name (current_: FORMAL_NAMED_SIGNATURE_TYPE; a_name: STRING) is
		external
			"IL static signature (FORMAL_NAMED_SIGNATURE_TYPE, STRING): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"$$set_eiffel_name"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_name (current_: FORMAL_NAMED_SIGNATURE_TYPE): STRING is
		external
			"IL static signature (FORMAL_NAMED_SIGNATURE_TYPE): STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"$$eiffel_name"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_set_external_name (current_: FORMAL_NAMED_SIGNATURE_TYPE; a_name: STRING) is
		external
			"IL static signature (FORMAL_NAMED_SIGNATURE_TYPE, STRING): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"$$set_external_name"
		end

	a_set_internal_type_eiffel_name (internal_type_eiffel_name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"_set_internal_type_eiffel_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"io"
		end

	set_external_name (a_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"set_external_name"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"deep_copy"
		end

	external_name: STRING is
		external
			"IL signature (): STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"external_name"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"conforms_to"
		end

	internal_type_full_external_name: STRING is
		external
			"IL signature (): STRING use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"internal_type_full_external_name"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_FORMAL_NAMED_SIGNATURE_TYPE
