indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.PRIMES"

external class
	IMPLEMENTATION_PRIMES

inherit
	CONTAINER_INT32
		rename
			has as is_prime
		end
	PRIMES
		rename
			occurrences as occurrences_int32,
			item as item_int32,
			index as index_int32,
			has as is_prime
		end
	BAG_INT32
		rename
			occurrences as occurrences_int32,
			has as is_prime
		end
	BOX_INT32
		rename
			has as is_prime
		end
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ACTIVE_INT32
		rename
			occurrences as occurrences_int32,
			item as item_int32,
			has as is_prime
		end
	TRAVERSABLE_INT32
		rename
			item as item_int32,
			has as is_prime
		end
	COUNTABLE_SEQUENCE_INT32
		rename
			occurrences as occurrences_int32,
			item as item_int32,
			index as index_int32,
			has as is_prime
		end
	COUNTABLE_INT32
		rename
			item as item_int322,
			has as is_prime
		end
	INFINITE_INT32
		rename
			has as is_prime
		end
	LINEAR_INT32
		rename
			occurrences as occurrences_int32,
			item as item_int32,
			index as index_int32,
			has as is_prime
		end
	COLLECTION_INT32
		rename
			has as is_prime
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.PRIMES"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.PRIMES"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_index: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.PRIMES"
		alias
			"$$index"
		end

feature -- Basic Operations

	smallest_prime: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PRIMES"
		alias
			"smallest_prime"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.PRIMES"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.PRIMES"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.PRIMES"
		alias
			"default_create"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.PRIMES"
		alias
			"start"
		end

	item_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PRIMES"
		alias
			"item"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.PRIMES"
		alias
			"finish"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.PRIMES"
		alias
			"generator"
		end

	higher_prime (n: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.PRIMES"
		alias
			"higher_prime"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.PRIMES"
		alias
			"do_if"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.PRIMES"
		alias
			"_set_index"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PRIMES"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.PRIMES"
		alias
			"generating_type"
		end

	put (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.PRIMES"
		alias
			"put"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.PRIMES"
		alias
			"out"
		end

	is_inserted (v: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.PRIMES"
		alias
			"is_inserted"
		end

	prune (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.PRIMES"
		alias
			"prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.PRIMES"
		alias
			"changeable_comparison_criterion"
		end

	forth is
		external
			"IL signature (): System.Void use Implementation.PRIMES"
		alias
			"forth"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.PRIMES"
		alias
			"there_exists"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PRIMES"
		alias
			"conforms_to"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.PRIMES"
		alias
			"io"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.PRIMES"
		alias
			"remove"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.PRIMES"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.PRIMES"
		alias
			"empty"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.PRIMES"
		alias
			"after"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.PRIMES"
		alias
			"tagged_out"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.PRIMES"
		alias
			"readable"
		end

	item_int322 (i: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.PRIMES"
		alias
			"i_th"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.PRIMES"
		alias
			"do_all"
		end

	index_of (v: INTEGER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use Implementation.PRIMES"
		alias
			"index_of"
		end

	fill (other: CONTAINER_INT32) is
		external
			"IL signature (CONTAINER_INT32): System.Void use Implementation.PRIMES"
		alias
			"fill"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.PRIMES"
		alias
			"extendible"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.PRIMES"
		alias
			"do_nothing"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.PRIMES"
		alias
			"compare_objects"
		end

	occurrences_int32 (v: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.PRIMES"
		alias
			"occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_lower_prime (current_: PRIMES; n: INTEGER): INTEGER is
		external
			"IL static signature (PRIMES, System.Int32): System.Int32 use Implementation.PRIMES"
		alias
			"$$lower_prime"
		end

	frozen ec_illegal_36_ec_illegal_36_smallest_odd_prime (current_: PRIMES): INTEGER is
		external
			"IL static signature (PRIMES): System.Int32 use Implementation.PRIMES"
		alias
			"$$smallest_odd_prime"
		end

	prune_all (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.PRIMES"
		alias
			"prune_all"
		end

	is_prime (n: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.PRIMES"
		alias
			"is_prime"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.PRIMES"
		alias
			"off"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.PRIMES"
		alias
			"writable"
		end

	frozen ec_illegal_36_ec_illegal_36_all_lower_primes (current_: PRIMES; n: INTEGER): ARRAY_BOOLEAN is
		external
			"IL static signature (PRIMES, System.Int32): ARRAY_BOOLEAN use Implementation.PRIMES"
		alias
			"$$all_lower_primes"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PRIMES"
		alias
			"standard_is_equal"
		end

	all_lower_primes (n: INTEGER): ARRAY_BOOLEAN is
		external
			"IL signature (System.Int32): ARRAY_BOOLEAN use Implementation.PRIMES"
		alias
			"all_lower_primes"
		end

	linear_representation: LINEAR_INT32 is
		external
			"IL signature (): LINEAR_INT32 use Implementation.PRIMES"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.PRIMES"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.PRIMES"
		alias
			"default"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PRIMES"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.PRIMES"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.PRIMES"
		alias
			"compare_references"
		end

	index_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PRIMES"
		alias
			"index"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.PRIMES"
		alias
			"full"
		end

	frozen ec_illegal_36_ec_illegal_36_i_th (current_: PRIMES; i: INTEGER): INTEGER is
		external
			"IL static signature (PRIMES, System.Int32): System.Int32 use Implementation.PRIMES"
		alias
			"$$i_th"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PRIMES"
		alias
			"print"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.PRIMES"
		alias
			"exhausted"
		end

	replace (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.PRIMES"
		alias
			"replace"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.PRIMES"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_higher_prime (current_: PRIMES; n: INTEGER): INTEGER is
		external
			"IL static signature (PRIMES, System.Int32): System.Int32 use Implementation.PRIMES"
		alias
			"$$higher_prime"
		end

	extend (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.PRIMES"
		alias
			"extend"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.PRIMES"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.PRIMES"
		alias
			"standard_equal"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.PRIMES"
		alias
			"prunable"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PRIMES"
		alias
			"same_type"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PRIMES"
		alias
			"standard_copy"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PRIMES"
		alias
			"GetHashCode"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.PRIMES"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.PRIMES"
		alias
			"Equals"
		end

	lower_prime (n: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.PRIMES"
		alias
			"lower_prime"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.PRIMES"
		alias
			"deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_smallest_prime (current_: PRIMES): INTEGER is
		external
			"IL static signature (PRIMES): System.Int32 use Implementation.PRIMES"
		alias
			"$$smallest_prime"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.PRIMES"
		alias
			"standard_clone"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.PRIMES"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.PRIMES"
		alias
			"internal_clone"
		end

	smallest_odd_prime: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PRIMES"
		alias
			"smallest_odd_prime"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.PRIMES"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PRIMES"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.PRIMES"
		alias
			"_set_object_comparison"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.PRIMES"
		alias
			"ToString"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.PRIMES"
		alias
			"wipe_out"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PRIMES"
		alias
			"deep_copy"
		end

	search (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.PRIMES"
		alias
			"search"
		end

	frozen ec_illegal_36_ec_illegal_36_is_prime (current_: PRIMES; n: INTEGER): BOOLEAN is
		external
			"IL static signature (PRIMES, System.Int32): System.Boolean use Implementation.PRIMES"
		alias
			"$$is_prime"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.PRIMES"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_PRIMES
