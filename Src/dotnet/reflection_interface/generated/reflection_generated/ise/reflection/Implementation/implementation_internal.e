indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.INTERNAL"

external class
	IMPLEMENTATION_INTERNAL

inherit
	INTERNAL
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
			"IL creator use Implementation.INTERNAL"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.INTERNAL"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.INTERNAL"
		alias
			"____class_name"
		end

	frozen ec_illegal_36_ec_illegal_36_real_type (current_: INTERNAL): INTEGER is
		external
			"IL static signature (INTERNAL): System.Int32 use Implementation.INTERNAL"
		alias
			"$$real_type"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.INTERNAL"
		alias
			"default_create"
		end

	real_field (i: INTEGER; object: ANY): REAL is
		external
			"IL signature (System.Int32, ANY): System.Single use Implementation.INTERNAL"
		alias
			"real_field"
		end

	field_offset (i: INTEGER; object: ANY): INTEGER is
		external
			"IL signature (System.Int32, ANY): System.Int32 use Implementation.INTERNAL"
		alias
			"field_offset"
		end

	frozen ec_illegal_36_ec_illegal_36_set_boolean_field (current_: INTERNAL; i: INTEGER; object: ANY; value: BOOLEAN) is
		external
			"IL static signature (INTERNAL, System.Int32, ANY, System.Boolean): System.Void use Implementation.INTERNAL"
		alias
			"$$set_boolean_field"
		end

	frozen ec_illegal_36_ec_illegal_36_field_type_of_type (current_: INTERNAL; i: INTEGER; type_id: INTEGER): INTEGER is
		external
			"IL static signature (INTERNAL, System.Int32, System.Int32): System.Int32 use Implementation.INTERNAL"
		alias
			"$$field_type_of_type"
		end

	frozen ec_illegal_36_ec_illegal_36_dynamic_type_from_string (current_: INTERNAL; class_type: STRING): INTEGER is
		external
			"IL static signature (INTERNAL, STRING): System.Int32 use Implementation.INTERNAL"
		alias
			"$$dynamic_type_from_string"
		end

	frozen ec_illegal_36_ec_illegal_36_set_reference_field (current_: INTERNAL; i: INTEGER; object: ANY; value: ANY) is
		external
			"IL static signature (INTERNAL, System.Int32, ANY, ANY): System.Void use Implementation.INTERNAL"
		alias
			"$$set_reference_field"
		end

	class_name (object: ANY): STRING is
		external
			"IL signature (ANY): STRING use Implementation.INTERNAL"
		alias
			"class_name"
		end

	frozen ec_illegal_36_ec_illegal_36_expanded_field_type (current_: INTERNAL; i: INTEGER; object: ANY): STRING is
		external
			"IL static signature (INTERNAL, System.Int32, ANY): STRING use Implementation.INTERNAL"
		alias
			"$$expanded_field_type"
		end

	frozen ec_illegal_36_ec_illegal_36_physical_size (current_: INTERNAL; object: ANY): INTEGER is
		external
			"IL static signature (INTERNAL, ANY): System.Int32 use Implementation.INTERNAL"
		alias
			"$$physical_size"
		end

	frozen ec_illegal_36_ec_illegal_36_type_conforms_to (current_: INTERNAL; type1: INTEGER; type2: INTEGER): BOOLEAN is
		external
			"IL static signature (INTERNAL, System.Int32, System.Int32): System.Boolean use Implementation.INTERNAL"
		alias
			"$$type_conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_field (current_: INTERNAL; i: INTEGER; object: ANY): ANY is
		external
			"IL static signature (INTERNAL, System.Int32, ANY): ANY use Implementation.INTERNAL"
		alias
			"$$field"
		end

	set_boolean_field (i: INTEGER; object: ANY; value: BOOLEAN) is
		external
			"IL signature (System.Int32, ANY, System.Boolean): System.Void use Implementation.INTERNAL"
		alias
			"set_boolean_field"
		end

	double_type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTERNAL"
		alias
			"double_type"
		end

	double_field (i: INTEGER; object: ANY): DOUBLE is
		external
			"IL signature (System.Int32, ANY): System.Double use Implementation.INTERNAL"
		alias
			"double_field"
		end

	set_character_field (i: INTEGER; object: ANY; value: CHARACTER) is
		external
			"IL signature (System.Int32, ANY, System.Char): System.Void use Implementation.INTERNAL"
		alias
			"set_character_field"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INTERNAL"
		alias
			"copy"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_32_type (current_: INTERNAL): INTEGER is
		external
			"IL static signature (INTERNAL): System.Int32 use Implementation.INTERNAL"
		alias
			"$$integer_32_type"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.INTERNAL"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_field_type (current_: INTERNAL; i: INTEGER; object: ANY): INTEGER is
		external
			"IL static signature (INTERNAL, System.Int32, ANY): System.Int32 use Implementation.INTERNAL"
		alias
			"$$field_type"
		end

	frozen ec_illegal_36_ec_illegal_36_double_type (current_: INTERNAL): INTEGER is
		external
			"IL static signature (INTERNAL): System.Int32 use Implementation.INTERNAL"
		alias
			"$$double_type"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.INTERNAL"
		alias
			"out"
		end

	get_type_index (t: TYPE): INTEGER is
		external
			"IL signature (System.Type): System.Int32 use Implementation.INTERNAL"
		alias
			"get_type_index"
		end

	frozen ec_illegal_36_ec_illegal_36_pointer_field (current_: INTERNAL; i: INTEGER; object: ANY): POINTER is
		external
			"IL static signature (INTERNAL, System.Int32, ANY): System.IntPtr use Implementation.INTERNAL"
		alias
			"$$pointer_field"
		end

	frozen ec_illegal_36_ec_illegal_36_generic_parameter_count (current_: INTERNAL; object: ANY): INTEGER is
		external
			"IL static signature (INTERNAL, ANY): System.Int32 use Implementation.INTERNAL"
		alias
			"$$generic_parameter_count"
		end

	physical_size (object: ANY): INTEGER is
		external
			"IL signature (ANY): System.Int32 use Implementation.INTERNAL"
		alias
			"physical_size"
		end

	frozen ec_illegal_36_ec_illegal_36_class_name (current_: INTERNAL; object: ANY): STRING is
		external
			"IL static signature (INTERNAL, ANY): STRING use Implementation.INTERNAL"
		alias
			"$$class_name"
		end

	reference_type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTERNAL"
		alias
			"reference_type"
		end

	bit_size (i: INTEGER; object: ANY): INTEGER is
		external
			"IL signature (System.Int32, ANY): System.Int32 use Implementation.INTERNAL"
		alias
			"bit_size"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.INTERNAL"
		alias
			"standard_equal"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.INTERNAL"
		alias
			"default_rescue"
		end

	frozen ec_illegal_36_ec_illegal_36_wide_character_type (current_: INTERNAL): INTEGER is
		external
			"IL static signature (INTERNAL): System.Int32 use Implementation.INTERNAL"
		alias
			"$$wide_character_type"
		end

	frozen ec_illegal_36_ec_illegal_36_field_name (current_: INTERNAL; i: INTEGER; object: ANY): STRING is
		external
			"IL static signature (INTERNAL, System.Int32, ANY): STRING use Implementation.INTERNAL"
		alias
			"$$field_name"
		end

	field_count_of_type (type_id: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.INTERNAL"
		alias
			"field_count_of_type"
		end

	type_conforms_to (type1: INTEGER; type2: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32): System.Boolean use Implementation.INTERNAL"
		alias
			"type_conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_field_count (current_: INTERNAL; object: ANY): INTEGER is
		external
			"IL static signature (INTERNAL, ANY): System.Int32 use Implementation.INTERNAL"
		alias
			"$$field_count"
		end

	generic_dynamic_type (object: ANY; i: INTEGER): INTEGER is
		external
			"IL signature (ANY, System.Int32): System.Int32 use Implementation.INTERNAL"
		alias
			"generic_dynamic_type"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INTERNAL"
		alias
			"conforms_to"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.INTERNAL"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_set_pointer_field (current_: INTERNAL; i: INTEGER; object: ANY; value: POINTER) is
		external
			"IL static signature (INTERNAL, System.Int32, ANY, System.IntPtr): System.Void use Implementation.INTERNAL"
		alias
			"$$set_pointer_field"
		end

	set_integer_field (i: INTEGER; object: ANY; value: INTEGER) is
		external
			"IL signature (System.Int32, ANY, System.Int32): System.Void use Implementation.INTERNAL"
		alias
			"set_integer_field"
		end

	frozen ec_illegal_36_ec_illegal_36_get_type_index (current_: INTERNAL; t: TYPE): INTEGER is
		external
			"IL static signature (INTERNAL, System.Type): System.Int32 use Implementation.INTERNAL"
		alias
			"$$get_type_index"
		end

	frozen ec_illegal_36_ec_illegal_36_bit_size (current_: INTERNAL; i: INTEGER; object: ANY): INTEGER is
		external
			"IL static signature (INTERNAL, System.Int32, ANY): System.Int32 use Implementation.INTERNAL"
		alias
			"$$bit_size"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_8_type (current_: INTERNAL): INTEGER is
		external
			"IL static signature (INTERNAL): System.Int32 use Implementation.INTERNAL"
		alias
			"$$integer_8_type"
		end

	frozen ec_illegal_36_ec_illegal_36_dynamic_type (current_: INTERNAL; object: ANY): INTEGER is
		external
			"IL static signature (INTERNAL, ANY): System.Int32 use Implementation.INTERNAL"
		alias
			"$$dynamic_type"
		end

	frozen ec_illegal_36_ec_illegal_36_expanded_type (current_: INTERNAL): INTEGER is
		external
			"IL static signature (INTERNAL): System.Int32 use Implementation.INTERNAL"
		alias
			"$$expanded_type"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.INTERNAL"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_reference_type (current_: INTERNAL): INTEGER is
		external
			"IL static signature (INTERNAL): System.Int32 use Implementation.INTERNAL"
		alias
			"$$reference_type"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_type (current_: INTERNAL): INTEGER is
		external
			"IL static signature (INTERNAL): System.Int32 use Implementation.INTERNAL"
		alias
			"$$integer_type"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.INTERNAL"
		alias
			"default"
		end

	new_instance_of (type_id: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.INTERNAL"
		alias
			"new_instance_of"
		end

	character_field (i: INTEGER; object: ANY): CHARACTER is
		external
			"IL signature (System.Int32, ANY): System.Char use Implementation.INTERNAL"
		alias
			"character_field"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INTERNAL"
		alias
			"same_type"
		end

	frozen ec_illegal_36_ec_illegal_36_set_character_field (current_: INTERNAL; i: INTEGER; object: ANY; value: CHARACTER) is
		external
			"IL static signature (INTERNAL, System.Int32, ANY, System.Char): System.Void use Implementation.INTERNAL"
		alias
			"$$set_character_field"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.INTERNAL"
		alias
			"do_nothing"
		end

	dynamic_type (object: ANY): INTEGER is
		external
			"IL signature (ANY): System.Int32 use Implementation.INTERNAL"
		alias
			"dynamic_type"
		end

	field (i: INTEGER; object: ANY): ANY is
		external
			"IL signature (System.Int32, ANY): ANY use Implementation.INTERNAL"
		alias
			"field"
		end

	frozen ec_illegal_36_ec_illegal_36_generic_dynamic_type (current_: INTERNAL; object: ANY; i: INTEGER): INTEGER is
		external
			"IL static signature (INTERNAL, ANY, System.Int32): System.Int32 use Implementation.INTERNAL"
		alias
			"$$generic_dynamic_type"
		end

	field_type (i: INTEGER; object: ANY): INTEGER is
		external
			"IL signature (System.Int32, ANY): System.Int32 use Implementation.INTERNAL"
		alias
			"field_type"
		end

	field_count (object: ANY): INTEGER is
		external
			"IL signature (ANY): System.Int32 use Implementation.INTERNAL"
		alias
			"field_count"
		end

	frozen ec_illegal_36_ec_illegal_36_compiler_version (current_: INTERNAL): INTEGER is
		external
			"IL static signature (INTERNAL): System.Int32 use Implementation.INTERNAL"
		alias
			"$$compiler_version"
		end

	frozen ec_illegal_36_ec_illegal_36_known_types (current_: INTERNAL): ARRAYED_LIST_ANY is
		external
			"IL static signature (INTERNAL): ARRAYED_LIST_ANY use Implementation.INTERNAL"
		alias
			"$$known_types"
		end

	bit_type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTERNAL"
		alias
			"bit_type"
		end

	set_double_field (i: INTEGER; object: ANY; value: DOUBLE) is
		external
			"IL signature (System.Int32, ANY, System.Double): System.Void use Implementation.INTERNAL"
		alias
			"set_double_field"
		end

	frozen ec_illegal_36_ec_illegal_36_character_type (current_: INTERNAL): INTEGER is
		external
			"IL static signature (INTERNAL): System.Int32 use Implementation.INTERNAL"
		alias
			"$$character_type"
		end

	real_type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTERNAL"
		alias
			"real_type"
		end

	field_name_of_type (i: INTEGER; type_id: INTEGER): STRING is
		external
			"IL signature (System.Int32, System.Int32): STRING use Implementation.INTERNAL"
		alias
			"field_name_of_type"
		end

	frozen ec_illegal_36_ec_illegal_36_pointer_type (current_: INTERNAL): INTEGER is
		external
			"IL static signature (INTERNAL): System.Int32 use Implementation.INTERNAL"
		alias
			"$$pointer_type"
		end

	dynamic_type_from_string (class_type: STRING): INTEGER is
		external
			"IL signature (STRING): System.Int32 use Implementation.INTERNAL"
		alias
			"dynamic_type_from_string"
		end

	expanded_type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTERNAL"
		alias
			"expanded_type"
		end

	frozen ec_illegal_36_ec_illegal_36_is_special (current_: INTERNAL; object: ANY): BOOLEAN is
		external
			"IL static signature (INTERNAL, ANY): System.Boolean use Implementation.INTERNAL"
		alias
			"$$is_special"
		end

	frozen ec_illegal_36_ec_illegal_36_is_instance_of (current_: INTERNAL; object: ANY; type_id: INTEGER): BOOLEAN is
		external
			"IL static signature (INTERNAL, ANY, System.Int32): System.Boolean use Implementation.INTERNAL"
		alias
			"$$is_instance_of"
		end

	frozen ec_illegal_36_ec_illegal_36_boolean_type (current_: INTERNAL): INTEGER is
		external
			"IL static signature (INTERNAL): System.Int32 use Implementation.INTERNAL"
		alias
			"$$boolean_type"
		end

	integer_64_type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTERNAL"
		alias
			"integer_64_type"
		end

	integer_16_type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTERNAL"
		alias
			"integer_16_type"
		end

	field_name (i: INTEGER; object: ANY): STRING is
		external
			"IL signature (System.Int32, ANY): STRING use Implementation.INTERNAL"
		alias
			"field_name"
		end

	pointer_field (i: INTEGER; object: ANY): POINTER is
		external
			"IL signature (System.Int32, ANY): System.IntPtr use Implementation.INTERNAL"
		alias
			"pointer_field"
		end

	generic_parameter_count (object: ANY): INTEGER is
		external
			"IL signature (ANY): System.Int32 use Implementation.INTERNAL"
		alias
			"generic_parameter_count"
		end

	character_type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTERNAL"
		alias
			"character_type"
		end

	integer_8_type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTERNAL"
		alias
			"integer_8_type"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.INTERNAL"
		alias
			"default_pointer"
		end

	set_reference_field (i: INTEGER; object: ANY; value: ANY) is
		external
			"IL signature (System.Int32, ANY, ANY): System.Void use Implementation.INTERNAL"
		alias
			"set_reference_field"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INTERNAL"
		alias
			"standard_is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_new_instance_of (current_: INTERNAL; type_id: INTEGER): ANY is
		external
			"IL static signature (INTERNAL, System.Int32): ANY use Implementation.INTERNAL"
		alias
			"$$new_instance_of"
		end

	expanded_field_type (i: INTEGER; object: ANY): STRING is
		external
			"IL signature (System.Int32, ANY): STRING use Implementation.INTERNAL"
		alias
			"expanded_field_type"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INTERNAL"
		alias
			"is_equal"
		end

	field_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use Implementation.INTERNAL"
		alias
			"field_type_of_type"
		end

	frozen ec_illegal_36_ec_illegal_36_set_integer_field (current_: INTERNAL; i: INTEGER; object: ANY; value: INTEGER) is
		external
			"IL static signature (INTERNAL, System.Int32, ANY, System.Int32): System.Void use Implementation.INTERNAL"
		alias
			"$$set_integer_field"
		end

	is_instance_of (object: ANY; type_id: INTEGER): BOOLEAN is
		external
			"IL signature (ANY, System.Int32): System.Boolean use Implementation.INTERNAL"
		alias
			"is_instance_of"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INTERNAL"
		alias
			"print"
		end

	frozen ec_illegal_36_ec_illegal_36_field_offset (current_: INTERNAL; i: INTEGER; object: ANY): INTEGER is
		external
			"IL static signature (INTERNAL, System.Int32, ANY): System.Int32 use Implementation.INTERNAL"
		alias
			"$$field_offset"
		end

	frozen ec_illegal_36_ec_illegal_36_field_name_of_type (current_: INTERNAL; i: INTEGER; type_id: INTEGER): STRING is
		external
			"IL static signature (INTERNAL, System.Int32, System.Int32): STRING use Implementation.INTERNAL"
		alias
			"$$field_name_of_type"
		end

	frozen ec_illegal_36_ec_illegal_36_real_field (current_: INTERNAL; i: INTEGER; object: ANY): REAL is
		external
			"IL static signature (INTERNAL, System.Int32, ANY): System.Single use Implementation.INTERNAL"
		alias
			"$$real_field"
		end

	integer_32_type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTERNAL"
		alias
			"integer_32_type"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.INTERNAL"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_boolean_field (current_: INTERNAL; i: INTEGER; object: ANY): BOOLEAN is
		external
			"IL static signature (INTERNAL, System.Int32, ANY): System.Boolean use Implementation.INTERNAL"
		alias
			"$$boolean_field"
		end

	boolean_field (i: INTEGER; object: ANY): BOOLEAN is
		external
			"IL signature (System.Int32, ANY): System.Boolean use Implementation.INTERNAL"
		alias
			"boolean_field"
		end

	get_members (type_id: INTEGER): ARRAYED_LIST_ANY is
		external
			"IL signature (System.Int32): ARRAYED_LIST_ANY use Implementation.INTERNAL"
		alias
			"get_members"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.INTERNAL"
		alias
			"clone"
		end

	integer_type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTERNAL"
		alias
			"integer_type"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_field (current_: INTERNAL; i: INTEGER; object: ANY): INTEGER is
		external
			"IL static signature (INTERNAL, System.Int32, ANY): System.Int32 use Implementation.INTERNAL"
		alias
			"$$integer_field"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INTERNAL"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_double_field (current_: INTERNAL; i: INTEGER; object: ANY): DOUBLE is
		external
			"IL static signature (INTERNAL, System.Int32, ANY): System.Double use Implementation.INTERNAL"
		alias
			"$$double_field"
		end

	known_types: ARRAYED_LIST_ANY is
		external
			"IL signature (): ARRAYED_LIST_ANY use Implementation.INTERNAL"
		alias
			"known_types"
		end

	frozen ec_illegal_36_ec_illegal_36_set_real_field (current_: INTERNAL; i: INTEGER; object: ANY; value: REAL) is
		external
			"IL static signature (INTERNAL, System.Int32, ANY, System.Single): System.Void use Implementation.INTERNAL"
		alias
			"$$set_real_field"
		end

	frozen ec_illegal_36_ec_illegal_36_get_members (current_: INTERNAL; type_id: INTEGER): ARRAYED_LIST_ANY is
		external
			"IL static signature (INTERNAL, System.Int32): ARRAYED_LIST_ANY use Implementation.INTERNAL"
		alias
			"$$get_members"
		end

	compiler_version: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTERNAL"
		alias
			"compiler_version"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_64_type (current_: INTERNAL): INTEGER is
		external
			"IL static signature (INTERNAL): System.Int32 use Implementation.INTERNAL"
		alias
			"$$integer_64_type"
		end

	frozen ec_illegal_36_ec_illegal_36_integer_16_type (current_: INTERNAL): INTEGER is
		external
			"IL static signature (INTERNAL): System.Int32 use Implementation.INTERNAL"
		alias
			"$$integer_16_type"
		end

	set_pointer_field (i: INTEGER; object: ANY; value: POINTER) is
		external
			"IL signature (System.Int32, ANY, System.IntPtr): System.Void use Implementation.INTERNAL"
		alias
			"set_pointer_field"
		end

	frozen ec_illegal_36_ec_illegal_36_set_double_field (current_: INTERNAL; i: INTEGER; object: ANY; value: DOUBLE) is
		external
			"IL static signature (INTERNAL, System.Int32, ANY, System.Double): System.Void use Implementation.INTERNAL"
		alias
			"$$set_double_field"
		end

	frozen ec_illegal_36_ec_illegal_36_field_count_of_type (current_: INTERNAL; type_id: INTEGER): INTEGER is
		external
			"IL static signature (INTERNAL, System.Int32): System.Int32 use Implementation.INTERNAL"
		alias
			"$$field_count_of_type"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.INTERNAL"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTERNAL"
		alias
			"GetHashCode"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.INTERNAL"
		alias
			"deep_equal"
		end

	is_special (object: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.INTERNAL"
		alias
			"is_special"
		end

	integer_field (i: INTEGER; object: ANY): INTEGER is
		external
			"IL signature (System.Int32, ANY): System.Int32 use Implementation.INTERNAL"
		alias
			"integer_field"
		end

	frozen ec_illegal_36_ec_illegal_36_character_field (current_: INTERNAL; i: INTEGER; object: ANY): CHARACTER is
		external
			"IL static signature (INTERNAL, System.Int32, ANY): System.Char use Implementation.INTERNAL"
		alias
			"$$character_field"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.INTERNAL"
		alias
			"standard_clone"
		end

	pointer_type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTERNAL"
		alias
			"pointer_type"
		end

	set_real_field (i: INTEGER; object: ANY; value: REAL) is
		external
			"IL signature (System.Int32, ANY, System.Single): System.Void use Implementation.INTERNAL"
		alias
			"set_real_field"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.INTERNAL"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.INTERNAL"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.INTERNAL"
		alias
			"deep_clone"
		end

	insert_type (t: TYPE) is
		external
			"IL signature (System.Type): System.Void use Implementation.INTERNAL"
		alias
			"insert_type"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INTERNAL"
		alias
			"internal_copy"
		end

	wide_character_type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTERNAL"
		alias
			"wide_character_type"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.INTERNAL"
		alias
			"ToString"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.INTERNAL"
		alias
			"deep_copy"
		end

	boolean_type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.INTERNAL"
		alias
			"boolean_type"
		end

	frozen ec_illegal_36_ec_illegal_36_bit_type (current_: INTERNAL): INTEGER is
		external
			"IL static signature (INTERNAL): System.Int32 use Implementation.INTERNAL"
		alias
			"$$bit_type"
		end

	frozen ec_illegal_36_ec_illegal_36_insert_type (current_: INTERNAL; t: TYPE) is
		external
			"IL static signature (INTERNAL, System.Type): System.Void use Implementation.INTERNAL"
		alias
			"$$insert_type"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.INTERNAL"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_INTERNAL
