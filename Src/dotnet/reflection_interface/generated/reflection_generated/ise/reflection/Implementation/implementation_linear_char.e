indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.LINEAR_CHAR"

deferred external class
	IMPLEMENTATION_LINEAR_CHAR

inherit
	CONTAINER_CHAR
	LINEAR_CHAR
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	TRAVERSABLE_CHAR

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.LINEAR_CHAR"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.LINEAR_CHAR"
		alias
			"deep_clone"
		end

	search (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.LINEAR_CHAR"
		alias
			"search"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.LINEAR_CHAR"
		alias
			"_set_object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_do_if (current_: LINEAR_CHAR; action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL static signature (LINEAR_CHAR, PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.LINEAR_CHAR"
		alias
			"$$do_if"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.LINEAR_CHAR"
		alias
			"compare_references"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.LINEAR_CHAR"
		alias
			"tagged_out"
		end

	has (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"has"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.LINEAR_CHAR"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.LINEAR_CHAR"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"same_type"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.LINEAR_CHAR"
		alias
			"generator"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"changeable_comparison_criterion"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINEAR_CHAR"
		alias
			"internal_copy"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.LINEAR_CHAR"
		alias
			"compare_objects"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"there_exists"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.LINEAR_CHAR"
		alias
			"standard_clone"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.LINEAR_CHAR"
		alias
			"do_if"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_off (current_: LINEAR_CHAR): BOOLEAN is
		external
			"IL static signature (LINEAR_CHAR): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"$$off"
		end

	frozen ec_illegal_36_ec_illegal_36_do_all (current_: LINEAR_CHAR; action: PROCEDURE_ANY_ANY) is
		external
			"IL static signature (LINEAR_CHAR, PROCEDURE_ANY_ANY): System.Void use Implementation.LINEAR_CHAR"
		alias
			"$$do_all"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.LINEAR_CHAR"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.LINEAR_CHAR"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.LINEAR_CHAR"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.LINEAR_CHAR"
		alias
			"default_rescue"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"off"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.LINEAR_CHAR"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINEAR_CHAR"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.LINEAR_CHAR"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.LINEAR_CHAR"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_linear_representation (current_: LINEAR_CHAR): LINEAR_CHAR is
		external
			"IL static signature (LINEAR_CHAR): LINEAR_CHAR use Implementation.LINEAR_CHAR"
		alias
			"$$linear_representation"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_for_all (current_: LINEAR_CHAR; test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL static signature (LINEAR_CHAR, FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"$$for_all"
		end

	frozen ec_illegal_36_ec_illegal_36_index_of (current_: LINEAR_CHAR; v: CHARACTER; i: INTEGER): INTEGER is
		external
			"IL static signature (LINEAR_CHAR, System.Char, System.Int32): System.Int32 use Implementation.LINEAR_CHAR"
		alias
			"$$index_of"
		end

	frozen ec_illegal_36_ec_illegal_36_occurrences (current_: LINEAR_CHAR; v: CHARACTER): INTEGER is
		external
			"IL static signature (LINEAR_CHAR, System.Char): System.Int32 use Implementation.LINEAR_CHAR"
		alias
			"$$occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_there_exists (current_: LINEAR_CHAR; test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL static signature (LINEAR_CHAR, FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"$$there_exists"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.LINEAR_CHAR"
		alias
			"do_all"
		end

	frozen ec_illegal_36_ec_illegal_36_exhausted (current_: LINEAR_CHAR): BOOLEAN is
		external
			"IL static signature (LINEAR_CHAR): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"$$exhausted"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.LINEAR_CHAR"
		alias
			"generating_type"
		end

	linear_representation: LINEAR_CHAR is
		external
			"IL signature (): LINEAR_CHAR use Implementation.LINEAR_CHAR"
		alias
			"linear_representation"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"object_comparison"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"for_all"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.LINEAR_CHAR"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.LINEAR_CHAR"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.LINEAR_CHAR"
		alias
			"clone"
		end

	index_of (v: CHARACTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use Implementation.LINEAR_CHAR"
		alias
			"index_of"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINEAR_CHAR"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINEAR_CHAR"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"conforms_to"
		end

	occurrences (v: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use Implementation.LINEAR_CHAR"
		alias
			"occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_search (current_: LINEAR_CHAR; v: CHARACTER) is
		external
			"IL static signature (LINEAR_CHAR, System.Char): System.Void use Implementation.LINEAR_CHAR"
		alias
			"$$search"
		end

	frozen ec_illegal_36_ec_illegal_36_has (current_: LINEAR_CHAR; v: CHARACTER): BOOLEAN is
		external
			"IL static signature (LINEAR_CHAR, System.Char): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"$$has"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINEAR_CHAR"
		alias
			"print"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINEAR_CHAR"
		alias
			"exhausted"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.LINEAR_CHAR"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_LINEAR_CHAR
