indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.SEQUENCE_SINGLE"

deferred external class
	IMPLEMENTATION_SEQUENCE_SINGLE

inherit
	BOX_SINGLE
	CONTAINER_SINGLE
	TRAVERSABLE_SINGLE
	LINEAR_SINGLE
		rename
			occurrences as occurrences_single
		end
	FINITE_SINGLE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SEQUENCE_SINGLE
		rename
			occurrences as occurrences_single
		end
	BILINEAR_SINGLE
		rename
			occurrences as occurrences_single
		end
	ACTIVE_SINGLE
		rename
			occurrences as occurrences_single
		end
	BAG_SINGLE
		rename
			occurrences as occurrences_single
		end
	COLLECTION_SINGLE

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.SEQUENCE_SINGLE"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SEQUENCE_SINGLE"
		alias
			"deep_clone"
		end

	search (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"search"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"_set_object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_append (current_: SEQUENCE_SINGLE; s: SEQUENCE_SINGLE) is
		external
			"IL static signature (SEQUENCE_SINGLE, SEQUENCE_SINGLE): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"$$append"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"compare_references"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.SEQUENCE_SINGLE"
		alias
			"tagged_out"
		end

	has (v: REAL): BOOLEAN is
		external
			"IL signature (System.Single): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"has"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.SEQUENCE_SINGLE"
		alias
			"internal_clone"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"same_type"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"empty"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.SEQUENCE_SINGLE"
		alias
			"operating_environment"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: SEQUENCE_SINGLE; v: REAL) is
		external
			"IL static signature (SEQUENCE_SINGLE, System.Single): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"$$prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"changeable_comparison_criterion"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"internal_copy"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.SEQUENCE_SINGLE"
		alias
			"generator"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"compare_objects"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"there_exists"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SEQUENCE_SINGLE"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"equal"
		end

	is_inserted (v: REAL): BOOLEAN is
		external
			"IL signature (System.Single): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"is_inserted"
		end

	linear_representation: LINEAR_SINGLE is
		external
			"IL signature (): LINEAR_SINGLE use Implementation.SEQUENCE_SINGLE"
		alias
			"linear_representation"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"is_empty"
		end

	occurrences_single (v: REAL): INTEGER is
		external
			"IL signature (System.Single): System.Int32 use Implementation.SEQUENCE_SINGLE"
		alias
			"occurrences"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SEQUENCE_SINGLE"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.SEQUENCE_SINGLE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"default_rescue"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"off"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.SEQUENCE_SINGLE"
		alias
			"default_pointer"
		end

	prune (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"prune"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"standard_copy"
		end

	force (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"force"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SEQUENCE_SINGLE"
		alias
			"ToString"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"readable"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.SEQUENCE_SINGLE"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"Equals"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"writable"
		end

	fill (other: CONTAINER_SINGLE) is
		external
			"IL signature (CONTAINER_SINGLE): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"fill"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all (current_: SEQUENCE_SINGLE; v: REAL) is
		external
			"IL static signature (SEQUENCE_SINGLE, System.Single): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"$$prune_all"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: SEQUENCE_SINGLE; v: REAL) is
		external
			"IL static signature (SEQUENCE_SINGLE, System.Single): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"$$put"
		end

	append (s: SEQUENCE_SINGLE) is
		external
			"IL signature (SEQUENCE_SINGLE): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"append"
		end

	sequential_search (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"sequential_search"
		end

	frozen ec_illegal_36_ec_illegal_36_readable (current_: SEQUENCE_SINGLE): BOOLEAN is
		external
			"IL static signature (SEQUENCE_SINGLE): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"$$readable"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"do_all"
		end

	prune_all (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"prune_all"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.SEQUENCE_SINGLE"
		alias
			"generating_type"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"do_if"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"object_comparison"
		end

	put (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"put"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"for_all"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.SEQUENCE_SINGLE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SEQUENCE_SINGLE"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_writable (current_: SEQUENCE_SINGLE): BOOLEAN is
		external
			"IL static signature (SEQUENCE_SINGLE): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"$$writable"
		end

	index_of (v: REAL; i: INTEGER): INTEGER is
		external
			"IL signature (System.Single, System.Int32): System.Int32 use Implementation.SEQUENCE_SINGLE"
		alias
			"index_of"
		end

	frozen ec_illegal_36_ec_illegal_36_force (current_: SEQUENCE_SINGLE; v: REAL) is
		external
			"IL static signature (SEQUENCE_SINGLE, System.Single): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"$$force"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"conforms_to"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"print"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_SINGLE"
		alias
			"exhausted"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_SINGLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_SEQUENCE_SINGLE
