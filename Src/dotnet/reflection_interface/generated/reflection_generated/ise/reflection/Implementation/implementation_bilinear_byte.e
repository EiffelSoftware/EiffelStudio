indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.BILINEAR_BYTE"

deferred external class
	IMPLEMENTATION_BILINEAR_BYTE

inherit
	LINEAR_BYTE
	BILINEAR_BYTE
	CONTAINER_BYTE
	TRAVERSABLE_BYTE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.BILINEAR_BYTE"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.BILINEAR_BYTE"
		alias
			"deep_clone"
		end

	search (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"search"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"_set_object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"compare_references"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.BILINEAR_BYTE"
		alias
			"tagged_out"
		end

	has (v: INTEGER_8): BOOLEAN is
		external
			"IL signature (System.Byte): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"has"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.BILINEAR_BYTE"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.BILINEAR_BYTE"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"same_type"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.BILINEAR_BYTE"
		alias
			"generator"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"changeable_comparison_criterion"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"internal_copy"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"compare_objects"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"there_exists"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.BILINEAR_BYTE"
		alias
			"standard_clone"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"do_if"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_off (current_: BILINEAR_BYTE): BOOLEAN is
		external
			"IL static signature (BILINEAR_BYTE): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"$$off"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.BILINEAR_BYTE"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.BILINEAR_BYTE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"default_rescue"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"off"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.BILINEAR_BYTE"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.BILINEAR_BYTE"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.BILINEAR_BYTE"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"Equals"
		end

	sequential_search (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"sequential_search"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"do_all"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.BILINEAR_BYTE"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_search (current_: BILINEAR_BYTE; v: INTEGER_8) is
		external
			"IL static signature (BILINEAR_BYTE, System.Byte): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"$$search"
		end

	linear_representation: LINEAR_BYTE is
		external
			"IL signature (): LINEAR_BYTE use Implementation.BILINEAR_BYTE"
		alias
			"linear_representation"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"object_comparison"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"for_all"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.BILINEAR_BYTE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.BILINEAR_BYTE"
		alias
			"clone"
		end

	index_of (v: INTEGER_8; i: INTEGER): INTEGER is
		external
			"IL signature (System.Byte, System.Int32): System.Int32 use Implementation.BILINEAR_BYTE"
		alias
			"index_of"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"conforms_to"
		end

	occurrences (v: INTEGER_8): INTEGER is
		external
			"IL signature (System.Byte): System.Int32 use Implementation.BILINEAR_BYTE"
		alias
			"occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_sequential_search (current_: BILINEAR_BYTE; v: INTEGER_8) is
		external
			"IL static signature (BILINEAR_BYTE, System.Byte): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"$$sequential_search"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"print"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.BILINEAR_BYTE"
		alias
			"exhausted"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.BILINEAR_BYTE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_BILINEAR_BYTE
