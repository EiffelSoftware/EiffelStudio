indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.LINEAR_BOOLEAN"

deferred external class
	IMPLEMENTATION_LINEAR_BOOLEAN

inherit
	TRAVERSABLE_BOOLEAN
	CONTAINER_BOOLEAN
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	LINEAR_BOOLEAN

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.LINEAR_BOOLEAN"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.LINEAR_BOOLEAN"
		alias
			"deep_clone"
		end

	search (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"search"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"_set_object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_do_if (current_: LINEAR_BOOLEAN; action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL static signature (LINEAR_BOOLEAN, PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"$$do_if"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"compare_references"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.LINEAR_BOOLEAN"
		alias
			"tagged_out"
		end

	has (v: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Boolean): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"has"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.LINEAR_BOOLEAN"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.LINEAR_BOOLEAN"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"same_type"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.LINEAR_BOOLEAN"
		alias
			"generator"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"changeable_comparison_criterion"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"internal_copy"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"compare_objects"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"there_exists"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.LINEAR_BOOLEAN"
		alias
			"standard_clone"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"do_if"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_off (current_: LINEAR_BOOLEAN): BOOLEAN is
		external
			"IL static signature (LINEAR_BOOLEAN): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"$$off"
		end

	frozen ec_illegal_36_ec_illegal_36_do_all (current_: LINEAR_BOOLEAN; action: PROCEDURE_ANY_ANY) is
		external
			"IL static signature (LINEAR_BOOLEAN, PROCEDURE_ANY_ANY): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"$$do_all"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.LINEAR_BOOLEAN"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.LINEAR_BOOLEAN"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"default_rescue"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"off"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.LINEAR_BOOLEAN"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.LINEAR_BOOLEAN"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.LINEAR_BOOLEAN"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_linear_representation (current_: LINEAR_BOOLEAN): LINEAR_BOOLEAN is
		external
			"IL static signature (LINEAR_BOOLEAN): LINEAR_BOOLEAN use Implementation.LINEAR_BOOLEAN"
		alias
			"$$linear_representation"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_for_all (current_: LINEAR_BOOLEAN; test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL static signature (LINEAR_BOOLEAN, FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"$$for_all"
		end

	frozen ec_illegal_36_ec_illegal_36_index_of (current_: LINEAR_BOOLEAN; v: BOOLEAN; i: INTEGER): INTEGER is
		external
			"IL static signature (LINEAR_BOOLEAN, System.Boolean, System.Int32): System.Int32 use Implementation.LINEAR_BOOLEAN"
		alias
			"$$index_of"
		end

	frozen ec_illegal_36_ec_illegal_36_occurrences (current_: LINEAR_BOOLEAN; v: BOOLEAN): INTEGER is
		external
			"IL static signature (LINEAR_BOOLEAN, System.Boolean): System.Int32 use Implementation.LINEAR_BOOLEAN"
		alias
			"$$occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_there_exists (current_: LINEAR_BOOLEAN; test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL static signature (LINEAR_BOOLEAN, FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"$$there_exists"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"do_all"
		end

	frozen ec_illegal_36_ec_illegal_36_exhausted (current_: LINEAR_BOOLEAN): BOOLEAN is
		external
			"IL static signature (LINEAR_BOOLEAN): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"$$exhausted"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.LINEAR_BOOLEAN"
		alias
			"generating_type"
		end

	linear_representation: LINEAR_BOOLEAN is
		external
			"IL signature (): LINEAR_BOOLEAN use Implementation.LINEAR_BOOLEAN"
		alias
			"linear_representation"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"object_comparison"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"for_all"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.LINEAR_BOOLEAN"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.LINEAR_BOOLEAN"
		alias
			"clone"
		end

	index_of (v: BOOLEAN; i: INTEGER): INTEGER is
		external
			"IL signature (System.Boolean, System.Int32): System.Int32 use Implementation.LINEAR_BOOLEAN"
		alias
			"index_of"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"conforms_to"
		end

	occurrences (v: BOOLEAN): INTEGER is
		external
			"IL signature (System.Boolean): System.Int32 use Implementation.LINEAR_BOOLEAN"
		alias
			"occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_search (current_: LINEAR_BOOLEAN; v: BOOLEAN) is
		external
			"IL static signature (LINEAR_BOOLEAN, System.Boolean): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"$$search"
		end

	frozen ec_illegal_36_ec_illegal_36_has (current_: LINEAR_BOOLEAN; v: BOOLEAN): BOOLEAN is
		external
			"IL static signature (LINEAR_BOOLEAN, System.Boolean): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"$$has"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"print"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINEAR_BOOLEAN"
		alias
			"exhausted"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.LINEAR_BOOLEAN"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_LINEAR_BOOLEAN
