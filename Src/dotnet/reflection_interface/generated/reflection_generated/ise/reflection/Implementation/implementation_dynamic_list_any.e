indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.DYNAMIC_LIST_ANY"

deferred external class
	IMPLEMENTATION_DYNAMIC_LIST_ANY

inherit
	CONTAINER_ANY
	BAG_ANY
		rename
			occurrences as occurrences_any
		end
	CURSOR_STRUCTURE_ANY
		rename
			occurrences as occurrences_any
		end
	SEQUENCE_ANY
		rename
			occurrences as occurrences_any
		end
	ACTIVE_ANY
		rename
			occurrences as occurrences_any
		end
	INDEXABLE_ANY_INT32
		rename
			occurrences as occurrences_any,
			valid_key as valid_index,
			item as item_int32
		end
	BOX_ANY
	FINITE_ANY
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	TRAVERSABLE_ANY
	LIST_ANY
		rename
			occurrences as occurrences_any,
			valid_key as valid_index
		end
	DYNAMIC_CHAIN_ANY
		rename
			occurrences as occurrences_any,
			valid_key as valid_index
		end
	DYNAMIC_LIST_ANY
		rename
			occurrences as occurrences_any,
			valid_key as valid_index
		end
	CHAIN_ANY
		rename
			occurrences as occurrences_any,
			valid_key as valid_index
		end
	COLLECTION_ANY
	LINEAR_ANY
		rename
			occurrences as occurrences_any
		end
	UNBOUNDED_ANY
	TABLE_ANY_INT32
		rename
			occurrences as occurrences_any,
			valid_key as valid_index,
			item as item_int32
		end
	BILINEAR_ANY
		rename
			occurrences as occurrences_any
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.DYNAMIC_LIST_ANY"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DYNAMIC_LIST_ANY"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"default_create"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"start"
		end

	last: ANY is
		external
			"IL signature (): ANY use Implementation.DYNAMIC_LIST_ANY"
		alias
			"last"
		end

	item_int32 (i: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.DYNAMIC_LIST_ANY"
		alias
			"i_th"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"finish"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"do_if"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_LIST_ANY"
		alias
			"generating_type"
		end

	put (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"put"
		end

	bag_put (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"bag_put"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_LIST_ANY"
		alias
			"out"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_left (current_: DYNAMIC_LIST_ANY; other: DYNAMIC_LIST_ANY) is
		external
			"IL static signature (DYNAMIC_LIST_ANY, DYNAMIC_LIST_ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"$$merge_left"
		end

	is_inserted (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"is_inserted"
		end

	prune (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"prune"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"changeable_comparison_criterion"
		end

	append (s: SEQUENCE_ANY) is
		external
			"IL signature (SEQUENCE_ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"append"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"valid_cursor_index"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"isfirst"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"there_exists"
		end

	sequential_index_of (v: ANY; i: INTEGER): INTEGER is
		external
			"IL signature (ANY, System.Int32): System.Int32 use Implementation.DYNAMIC_LIST_ANY"
		alias
			"sequential_index_of"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"conforms_to"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"move"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.DYNAMIC_LIST_ANY"
		alias
			"io"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.DYNAMIC_LIST_ANY"
		alias
			"GetHashCode"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"compare_objects"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"empty"
		end

	force (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"force"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"after"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_LIST_ANY"
		alias
			"tagged_out"
		end

	occurrences_any (v: ANY): INTEGER is
		external
			"IL signature (ANY): System.Int32 use Implementation.DYNAMIC_LIST_ANY"
		alias
			"occurrences"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"readable"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"before"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"do_all"
		end

	index_of (v: ANY; i: INTEGER): INTEGER is
		external
			"IL signature (ANY, System.Int32): System.Int32 use Implementation.DYNAMIC_LIST_ANY"
		alias
			"index_of"
		end

	fill (other: CONTAINER_ANY) is
		external
			"IL signature (CONTAINER_ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"fill"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"extendible"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: DYNAMIC_LIST_ANY) is
		external
			"IL static signature (DYNAMIC_LIST_ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"$$wipe_out"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.DYNAMIC_LIST_ANY"
		alias
			"index_set"
		end

	has (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"has"
		end

	first: ANY is
		external
			"IL signature (): ANY use Implementation.DYNAMIC_LIST_ANY"
		alias
			"first"
		end

	sequential_occurrences (v: ANY): INTEGER is
		external
			"IL signature (ANY): System.Int32 use Implementation.DYNAMIC_LIST_ANY"
		alias
			"sequential_occurrences"
		end

	prune_all (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"prune_all"
		end

	frozen ec_illegal_36_ec_illegal_36_chain_wipe_out (current_: DYNAMIC_LIST_ANY) is
		external
			"IL static signature (DYNAMIC_LIST_ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"$$chain_wipe_out"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"off"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"writable"
		end

	merge_left (other: DYNAMIC_CHAIN_ANY) is
		external
			"IL signature (DYNAMIC_CHAIN_ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"merge_left"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"standard_is_equal"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"swap"
		end

	put_any_int32 (v: ANY; i: INTEGER) is
		external
			"IL signature (ANY, System.Int32): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"put_i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_right (current_: DYNAMIC_LIST_ANY; other: DYNAMIC_LIST_ANY) is
		external
			"IL static signature (DYNAMIC_LIST_ANY, DYNAMIC_LIST_ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"$$merge_right"
		end

	chain_wipe_out is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"chain_wipe_out"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"go_i_th"
		end

	infix "@" (k: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.DYNAMIC_LIST_ANY"
		alias
			"infix "@""
		end

	linear_representation: LINEAR_ANY is
		external
			"IL signature (): LINEAR_ANY use Implementation.DYNAMIC_LIST_ANY"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.DYNAMIC_LIST_ANY"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.DYNAMIC_LIST_ANY"
		alias
			"default"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"compare_references"
		end

	duplicate (n: INTEGER): CHAIN_ANY is
		external
			"IL signature (System.Int32): CHAIN_ANY use Implementation.DYNAMIC_LIST_ANY"
		alias
			"duplicate"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"print"
		end

	sequential_search (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"sequential_search"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"valid_index"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"exhausted"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"equal"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DYNAMIC_LIST_ANY"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"standard_equal"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"prunable"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"same_type"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"standard_copy"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"Equals"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"islast"
		end

	merge_right (other: DYNAMIC_CHAIN_ANY) is
		external
			"IL signature (DYNAMIC_CHAIN_ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"merge_right"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"deep_equal"
		end

	put_left (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"put_left"
		end

	sequential_has (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.DYNAMIC_LIST_ANY"
		alias
			"sequential_has"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DYNAMIC_LIST_ANY"
		alias
			"standard_clone"
		end

	sequence_put (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"sequence_put"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.DYNAMIC_LIST_ANY"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.DYNAMIC_LIST_ANY"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.DYNAMIC_LIST_ANY"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"_set_object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_put_left (current_: DYNAMIC_LIST_ANY; v: ANY) is
		external
			"IL static signature (DYNAMIC_LIST_ANY, ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"$$put_left"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.DYNAMIC_LIST_ANY"
		alias
			"ToString"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"wipe_out"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"deep_copy"
		end

	search (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"search"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.DYNAMIC_LIST_ANY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_DYNAMIC_LIST_ANY
