indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.SEQUENCE_CHAR"

deferred external class
	IMPLEMENTATION_SEQUENCE_CHAR

inherit
	BOX_CHAR
	CONTAINER_CHAR
	SEQUENCE_CHAR
		rename
			occurrences as occurrences_char
		end
	TRAVERSABLE_CHAR
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	LINEAR_CHAR
		rename
			occurrences as occurrences_char
		end
	BAG_CHAR
		rename
			occurrences as occurrences_char
		end
	FINITE_CHAR
	ACTIVE_CHAR
		rename
			occurrences as occurrences_char
		end
	BILINEAR_CHAR
		rename
			occurrences as occurrences_char
		end
	COLLECTION_CHAR

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.SEQUENCE_CHAR"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SEQUENCE_CHAR"
		alias
			"deep_clone"
		end

	search (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"search"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"_set_object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_append (current_: SEQUENCE_CHAR; s: SEQUENCE_CHAR) is
		external
			"IL static signature (SEQUENCE_CHAR, SEQUENCE_CHAR): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"$$append"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"compare_references"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.SEQUENCE_CHAR"
		alias
			"tagged_out"
		end

	has (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"has"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.SEQUENCE_CHAR"
		alias
			"internal_clone"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"same_type"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"empty"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.SEQUENCE_CHAR"
		alias
			"operating_environment"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: SEQUENCE_CHAR; v: CHARACTER) is
		external
			"IL static signature (SEQUENCE_CHAR, System.Char): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"$$prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"changeable_comparison_criterion"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"internal_copy"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.SEQUENCE_CHAR"
		alias
			"generator"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"compare_objects"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"there_exists"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SEQUENCE_CHAR"
		alias
			"standard_clone"
		end

	occurrences_char (v: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use Implementation.SEQUENCE_CHAR"
		alias
			"occurrences"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"equal"
		end

	is_inserted (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"is_inserted"
		end

	linear_representation: LINEAR_CHAR is
		external
			"IL signature (): LINEAR_CHAR use Implementation.SEQUENCE_CHAR"
		alias
			"linear_representation"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"is_empty"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SEQUENCE_CHAR"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.SEQUENCE_CHAR"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"default_rescue"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"off"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.SEQUENCE_CHAR"
		alias
			"default_pointer"
		end

	prune (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"prune"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"standard_copy"
		end

	force (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"force"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.SEQUENCE_CHAR"
		alias
			"ToString"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"readable"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.SEQUENCE_CHAR"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"Equals"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"writable"
		end

	fill (other: CONTAINER_CHAR) is
		external
			"IL signature (CONTAINER_CHAR): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"fill"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all (current_: SEQUENCE_CHAR; v: CHARACTER) is
		external
			"IL static signature (SEQUENCE_CHAR, System.Char): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"$$prune_all"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: SEQUENCE_CHAR; v: CHARACTER) is
		external
			"IL static signature (SEQUENCE_CHAR, System.Char): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"$$put"
		end

	append (s: SEQUENCE_CHAR) is
		external
			"IL signature (SEQUENCE_CHAR): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"append"
		end

	sequential_search (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"sequential_search"
		end

	frozen ec_illegal_36_ec_illegal_36_readable (current_: SEQUENCE_CHAR): BOOLEAN is
		external
			"IL static signature (SEQUENCE_CHAR): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"$$readable"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"do_all"
		end

	prune_all (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"prune_all"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.SEQUENCE_CHAR"
		alias
			"generating_type"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"do_if"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"object_comparison"
		end

	put (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"put"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"for_all"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.SEQUENCE_CHAR"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.SEQUENCE_CHAR"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_writable (current_: SEQUENCE_CHAR): BOOLEAN is
		external
			"IL static signature (SEQUENCE_CHAR): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"$$writable"
		end

	index_of (v: CHARACTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use Implementation.SEQUENCE_CHAR"
		alias
			"index_of"
		end

	frozen ec_illegal_36_ec_illegal_36_force (current_: SEQUENCE_CHAR; v: CHARACTER) is
		external
			"IL static signature (SEQUENCE_CHAR, System.Char): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"$$force"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"conforms_to"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"print"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.SEQUENCE_CHAR"
		alias
			"exhausted"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.SEQUENCE_CHAR"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_SEQUENCE_CHAR
