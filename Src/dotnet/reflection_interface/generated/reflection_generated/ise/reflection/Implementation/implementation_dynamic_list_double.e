indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.DYNAMIC_LIST_DOUBLE"

deferred external class
	IMPLEMENTATION_DYNAMIC_LIST_DOUBLE

inherit
	DYNAMIC_CHAIN_DOUBLE
		rename
			occurrences as occurrences_double,
			valid_key as valid_index
		end
	INDEXABLE_DOUBLE_INT32
		rename
			occurrences as occurrences_double,
			valid_key as valid_index,
			item as item_int32
		end
	BILINEAR_DOUBLE
		rename
			occurrences as occurrences_double
		end
	ACTIVE_DOUBLE
		rename
			occurrences as occurrences_double
		end
	COLLECTION_DOUBLE
	LINEAR_DOUBLE
		rename
			occurrences as occurrences_double
		end
	BAG_DOUBLE
		rename
			occurrences as occurrences_double
		end
	TABLE_DOUBLE_INT32
		rename
			occurrences as occurrences_double,
			valid_key as valid_index,
			item as item_int32
		end
	SEQUENCE_DOUBLE
		rename
			occurrences as occurrences_double
		end
	BOX_DOUBLE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	TRAVERSABLE_DOUBLE
	FINITE_DOUBLE
	LIST_DOUBLE
		rename
			occurrences as occurrences_double,
			valid_key as valid_index
		end
	UNBOUNDED_DOUBLE
	CURSOR_STRUCTURE_DOUBLE
		rename
			occurrences as occurrences_double
		end
	CHAIN_DOUBLE
		rename
			occurrences as occurrences_double,
			valid_key as valid_index
		end
	CONTAINER_DOUBLE
	DYNAMIC_LIST_DOUBLE
		rename
			occurrences as occurrences_double,
			valid_key as valid_index
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"default_create"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"start"
		end

	last: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"last"
		end

	item_int32 (i: INTEGER): DOUBLE is
		external
			"IL signature (System.Int32): System.Double use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"i_th"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"finish"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"do_if"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"generating_type"
		end

	put (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"put"
		end

	bag_put (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"bag_put"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"out"
		end

	occurrences_double (v: DOUBLE): INTEGER is
		external
			"IL signature (System.Double): System.Int32 use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"occurrences"
		end

	is_inserted (v: DOUBLE): BOOLEAN is
		external
			"IL signature (System.Double): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"is_inserted"
		end

	prune (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"changeable_comparison_criterion"
		end

	append (s: SEQUENCE_DOUBLE) is
		external
			"IL signature (SEQUENCE_DOUBLE): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"append"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"valid_cursor_index"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"isfirst"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"there_exists"
		end

	sequential_index_of (v: DOUBLE; i: INTEGER): INTEGER is
		external
			"IL signature (System.Double, System.Int32): System.Int32 use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"sequential_index_of"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"conforms_to"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"move"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"io"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"GetHashCode"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"compare_objects"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_left (current_: DYNAMIC_LIST_DOUBLE; other: DYNAMIC_LIST_DOUBLE) is
		external
			"IL static signature (DYNAMIC_LIST_DOUBLE, DYNAMIC_LIST_DOUBLE): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"$$merge_left"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"empty"
		end

	force (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"force"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"after"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"tagged_out"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"readable"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"before"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"do_all"
		end

	index_of (v: DOUBLE; i: INTEGER): INTEGER is
		external
			"IL signature (System.Double, System.Int32): System.Int32 use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"index_of"
		end

	fill (other: CONTAINER_DOUBLE) is
		external
			"IL signature (CONTAINER_DOUBLE): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"fill"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"extendible"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: DYNAMIC_LIST_DOUBLE) is
		external
			"IL static signature (DYNAMIC_LIST_DOUBLE): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"$$wipe_out"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"index_set"
		end

	has (v: DOUBLE): BOOLEAN is
		external
			"IL signature (System.Double): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"has"
		end

	first: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"first"
		end

	sequential_occurrences (v: DOUBLE): INTEGER is
		external
			"IL signature (System.Double): System.Int32 use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"sequential_occurrences"
		end

	prune_all (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"prune_all"
		end

	frozen ec_illegal_36_ec_illegal_36_chain_wipe_out (current_: DYNAMIC_LIST_DOUBLE) is
		external
			"IL static signature (DYNAMIC_LIST_DOUBLE): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"$$chain_wipe_out"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"off"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"writable"
		end

	merge_left (other: DYNAMIC_CHAIN_DOUBLE) is
		external
			"IL signature (DYNAMIC_CHAIN_DOUBLE): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"merge_left"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"standard_is_equal"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"swap"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_right (current_: DYNAMIC_LIST_DOUBLE; other: DYNAMIC_LIST_DOUBLE) is
		external
			"IL static signature (DYNAMIC_LIST_DOUBLE, DYNAMIC_LIST_DOUBLE): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"$$merge_right"
		end

	chain_wipe_out is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"chain_wipe_out"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"go_i_th"
		end

	infix "@" (k: INTEGER): DOUBLE is
		external
			"IL signature (System.Int32): System.Double use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"infix "@""
		end

	linear_representation: LINEAR_DOUBLE is
		external
			"IL signature (): LINEAR_DOUBLE use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"default"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"compare_references"
		end

	duplicate (n: INTEGER): CHAIN_DOUBLE is
		external
			"IL signature (System.Int32): CHAIN_DOUBLE use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"duplicate"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"print"
		end

	sequential_search (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"sequential_search"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"valid_index"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"exhausted"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"equal"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"standard_equal"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"prunable"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"same_type"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"standard_copy"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"Equals"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"islast"
		end

	merge_right (other: DYNAMIC_CHAIN_DOUBLE) is
		external
			"IL signature (DYNAMIC_CHAIN_DOUBLE): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"merge_right"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"deep_equal"
		end

	put_left (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"put_left"
		end

	sequential_has (v: DOUBLE): BOOLEAN is
		external
			"IL signature (System.Double): System.Boolean use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"sequential_has"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"standard_clone"
		end

	sequence_put (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"sequence_put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"_set_object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_put_left (current_: DYNAMIC_LIST_DOUBLE; v: DOUBLE) is
		external
			"IL static signature (DYNAMIC_LIST_DOUBLE, System.Double): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"$$put_left"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"ToString"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"wipe_out"
		end

	put_double_int32 (v: DOUBLE; i: INTEGER) is
		external
			"IL signature (System.Double, System.Int32): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"put_i_th"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"deep_copy"
		end

	search (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"search"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_DOUBLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_DYNAMIC_LIST_DOUBLE
