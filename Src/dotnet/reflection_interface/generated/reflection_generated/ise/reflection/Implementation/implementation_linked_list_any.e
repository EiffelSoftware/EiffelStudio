indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.LINKED_LIST_ANY"

external class
	IMPLEMENTATION_LINKED_LIST_ANY

inherit
	CONTAINER_ANY
	LINEAR_ANY
		rename
			occurrences as occurrences_any,
			item as item_any,
			after as after_boolean
		end
	BAG_ANY
		rename
			occurrences as occurrences_any
		end
	CURSOR_STRUCTURE_ANY
		rename
			occurrences as occurrences_any,
			item as item_any
		end
	SEQUENCE_ANY
		rename
			occurrences as occurrences_any,
			item as item_any,
			count as count_int32,
			after as after_boolean,
			before as before_boolean
		end
	LINKED_LIST_ANY
		rename
			occurrences as occurrences_any,
			item as item_any,
			count as count_int32,
			after as after_boolean,
			before as before_boolean,
			valid_key as valid_index
		end
	INDEXABLE_ANY_INT32
		rename
			occurrences as occurrences_any,
			valid_key as valid_index,
			item as item_int32
		end
	BOX_ANY
	FINITE_ANY
		rename
			count as count_int32
		end
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	TRAVERSABLE_ANY
		rename
			item as item_any
		end
	LIST_ANY
		rename
			occurrences as occurrences_any,
			item as item_any,
			count as count_int32,
			after as after_boolean,
			before as before_boolean,
			valid_key as valid_index
		end
	DYNAMIC_CHAIN_ANY
		rename
			occurrences as occurrences_any,
			item as item_any,
			count as count_int32,
			after as after_boolean,
			before as before_boolean,
			valid_key as valid_index
		end
	DYNAMIC_LIST_ANY
		rename
			occurrences as occurrences_any,
			item as item_any,
			count as count_int32,
			after as after_boolean,
			before as before_boolean,
			valid_key as valid_index
		end
	CHAIN_ANY
		rename
			occurrences as occurrences_any,
			item as item_any,
			count as count_int32,
			after as after_boolean,
			before as before_boolean,
			valid_key as valid_index
		end
	COLLECTION_ANY
	ACTIVE_ANY
		rename
			occurrences as occurrences_any,
			item as item_any
		end
	UNBOUNDED_ANY
		rename
			count as count_int32
		end
	TABLE_ANY_INT32
		rename
			occurrences as occurrences_any,
			valid_key as valid_index,
			item as item_int32
		end
	BILINEAR_ANY
		rename
			occurrences as occurrences_any,
			item as item_any,
			after as after_boolean,
			before as before_boolean
		end

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.LINKED_LIST_ANY"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_active: LINKABLE_ANY is
		external
			"IL field signature :LINKABLE_ANY use Implementation.LINKED_LIST_ANY"
		alias
			"$$active"
		end

	frozen ec_illegal_36_ec_illegal_36_before: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"$$before"
		end

	frozen ec_illegal_36_ec_illegal_36_after: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"$$after"
		end

	frozen ec_illegal_36_ec_illegal_36_count: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.LINKED_LIST_ANY"
		alias
			"$$count"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_first_element: LINKABLE_ANY is
		external
			"IL field signature :LINKABLE_ANY use Implementation.LINKED_LIST_ANY"
		alias
			"$$first_element"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.LINKED_LIST_ANY"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.LINKED_LIST_ANY"
		alias
			"____class_name"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: LINKED_LIST_ANY) is
		external
			"IL static signature (LINKED_LIST_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$make"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"default_create"
		end

	item_any: ANY is
		external
			"IL signature (): ANY use Implementation.LINKED_LIST_ANY"
		alias
			"item"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor (current_: LINKED_LIST_ANY; p: CURSOR): BOOLEAN is
		external
			"IL static signature (LINKED_LIST_ANY, CURSOR): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"$$valid_cursor"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"start"
		end

	new_cell (v: ANY): LINKABLE_ANY is
		external
			"IL signature (ANY): LINKABLE_ANY use Implementation.LINKED_LIST_ANY"
		alias
			"new_cell"
		end

	frozen ec_illegal_36_ec_illegal_36_is_inserted (current_: LINKED_LIST_ANY; v: ANY): BOOLEAN is
		external
			"IL static signature (LINKED_LIST_ANY, ANY): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"$$is_inserted"
		end

	new_chain: DYNAMIC_CHAIN_ANY is
		external
			"IL signature (): DYNAMIC_CHAIN_ANY use Implementation.LINKED_LIST_ANY"
		alias
			"new_chain"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: LINKED_LIST_ANY) is
		external
			"IL static signature (LINKED_LIST_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$start"
		end

	frozen ec_illegal_36_ec_illegal_36_put_right (current_: LINKED_LIST_ANY; v: ANY) is
		external
			"IL static signature (LINKED_LIST_ANY, ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$put_right"
		end

	last: ANY is
		external
			"IL signature (): ANY use Implementation.LINKED_LIST_ANY"
		alias
			"last"
		end

	item_int32 (i: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.LINKED_LIST_ANY"
		alias
			"i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_go_to (current_: LINKED_LIST_ANY; p: CURSOR) is
		external
			"IL static signature (LINKED_LIST_ANY, CURSOR): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$go_to"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"finish"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"do_if"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_right (current_: LINKED_LIST_ANY) is
		external
			"IL static signature (LINKED_LIST_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$remove_right"
		end

	go_to (p: CURSOR) is
		external
			"IL signature (CURSOR): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"go_to"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.LINKED_LIST_ANY"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_last (current_: LINKED_LIST_ANY): ANY is
		external
			"IL static signature (LINKED_LIST_ANY): ANY use Implementation.LINKED_LIST_ANY"
		alias
			"$$last"
		end

	put (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"put"
		end

	last_element: LINKABLE_ANY is
		external
			"IL signature (): LINKABLE_ANY use Implementation.LINKED_LIST_ANY"
		alias
			"last_element"
		end

	next: LINKABLE_ANY is
		external
			"IL signature (): LINKABLE_ANY use Implementation.LINKED_LIST_ANY"
		alias
			"next"
		end

	bag_put (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"bag_put"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.LINKED_LIST_ANY"
		alias
			"out"
		end

	frozen ec_illegal_36_ec_illegal_36_put_front (current_: LINKED_LIST_ANY; v: ANY) is
		external
			"IL static signature (LINKED_LIST_ANY, ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$put_front"
		end

	frozen ec_illegal_36_ec_illegal_36_replace (current_: LINKED_LIST_ANY; v: ANY) is
		external
			"IL static signature (LINKED_LIST_ANY, ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$replace"
		end

	is_inserted (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"is_inserted"
		end

	put_front (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"put_front"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: LINKED_LIST_ANY): ANY is
		external
			"IL static signature (LINKED_LIST_ANY): ANY use Implementation.LINKED_LIST_ANY"
		alias
			"$$item"
		end

	prune (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"prune"
		end

	active: LINKABLE_ANY is
		external
			"IL signature (): LINKABLE_ANY use Implementation.LINKED_LIST_ANY"
		alias
			"active"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"changeable_comparison_criterion"
		end

	remove_left is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"remove_left"
		end

	frozen ec_illegal_36_ec_illegal_36_next (current_: LINKED_LIST_ANY): LINKABLE_ANY is
		external
			"IL static signature (LINKED_LIST_ANY): LINKABLE_ANY use Implementation.LINKED_LIST_ANY"
		alias
			"$$next"
		end

	append (s: SEQUENCE_ANY) is
		external
			"IL signature (SEQUENCE_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"append"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.LINKED_LIST_ANY"
		alias
			"GetHashCode"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"isfirst"
		end

	before_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"before"
		end

	frozen ec_illegal_36_ec_illegal_36_new_cell (current_: LINKED_LIST_ANY; v: ANY): LINKABLE_ANY is
		external
			"IL static signature (LINKED_LIST_ANY, ANY): LINKABLE_ANY use Implementation.LINKED_LIST_ANY"
		alias
			"$$new_cell"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"there_exists"
		end

	sequential_index_of (v: ANY; i: INTEGER): INTEGER is
		external
			"IL signature (ANY, System.Int32): System.Int32 use Implementation.LINKED_LIST_ANY"
		alias
			"sequential_index_of"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"conforms_to"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"move"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.LINKED_LIST_ANY"
		alias
			"io"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"remove"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"compare_objects"
		end

	frozen ec_illegal_36_ec_illegal_36_readable (current_: LINKED_LIST_ANY): BOOLEAN is
		external
			"IL static signature (LINKED_LIST_ANY): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"$$readable"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_left (current_: LINKED_LIST_ANY; other: LINKED_LIST_ANY) is
		external
			"IL static signature (LINKED_LIST_ANY, LINKED_LIST_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$merge_left"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"for_all"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"empty"
		end

	force (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"force"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"valid_cursor_index"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.LINKED_LIST_ANY"
		alias
			"tagged_out"
		end

	occurrences_any (v: ANY): INTEGER is
		external
			"IL signature (ANY): System.Int32 use Implementation.LINKED_LIST_ANY"
		alias
			"occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: LINKED_LIST_ANY) is
		external
			"IL static signature (LINKED_LIST_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$remove"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"readable"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: LINKED_LIST_ANY) is
		external
			"IL static signature (LINKED_LIST_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$finish"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"do_all"
		end

	index_of (v: ANY; i: INTEGER): INTEGER is
		external
			"IL signature (ANY, System.Int32): System.Int32 use Implementation.LINKED_LIST_ANY"
		alias
			"index_of"
		end

	fill (other: CONTAINER_ANY) is
		external
			"IL signature (CONTAINER_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"fill"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"extendible"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: LINKED_LIST_ANY) is
		external
			"IL static signature (LINKED_LIST_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$wipe_out"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.LINKED_LIST_ANY"
		alias
			"index_set"
		end

	has (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"has"
		end

	remove_right is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"remove_right"
		end

	first_element: LINKABLE_ANY is
		external
			"IL signature (): LINKABLE_ANY use Implementation.LINKED_LIST_ANY"
		alias
			"first_element"
		end

	first: ANY is
		external
			"IL signature (): ANY use Implementation.LINKED_LIST_ANY"
		alias
			"first"
		end

	sequential_occurrences (v: ANY): INTEGER is
		external
			"IL signature (ANY): System.Int32 use Implementation.LINKED_LIST_ANY"
		alias
			"sequential_occurrences"
		end

	prune_all (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"prune_all"
		end

	cleanup_after_remove (v: LINKABLE_ANY) is
		external
			"IL signature (LINKABLE_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"cleanup_after_remove"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_islast (current_: LINKED_LIST_ANY): BOOLEAN is
		external
			"IL static signature (LINKED_LIST_ANY): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"$$islast"
		end

	merge_right (other: DYNAMIC_CHAIN_ANY) is
		external
			"IL signature (DYNAMIC_CHAIN_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"merge_right"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.LINKED_LIST_ANY"
		alias
			"internal_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_left (current_: LINKED_LIST_ANY) is
		external
			"IL static signature (LINKED_LIST_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$remove_left"
		end

	merge_left (other: DYNAMIC_CHAIN_ANY) is
		external
			"IL signature (DYNAMIC_CHAIN_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"merge_left"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_wipe_out (current_: LINKED_LIST_ANY) is
		external
			"IL static signature (LINKED_LIST_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$internal_wipe_out"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"standard_is_equal"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"swap"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL signature (CURSOR): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"valid_cursor"
		end

	after_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"after"
		end

	put_any_int32 (v: ANY; i: INTEGER) is
		external
			"IL signature (ANY, System.Int32): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"put_i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_forth (current_: LINKED_LIST_ANY) is
		external
			"IL static signature (LINKED_LIST_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$forth"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_right (current_: LINKED_LIST_ANY; other: LINKED_LIST_ANY) is
		external
			"IL static signature (LINKED_LIST_ANY, LINKED_LIST_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$merge_right"
		end

	a_set_first_element (first_element2: LINKABLE_ANY) is
		external
			"IL signature (LINKABLE_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"_set_first_element"
		end

	a_set_after (after2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"_set_after"
		end

	chain_wipe_out is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"chain_wipe_out"
		end

	put_right (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"put_right"
		end

	forth is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"forth"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"go_i_th"
		end

	a_set_before (before2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"_set_before"
		end

	frozen ec_illegal_36_ec_illegal_36_go_i_th (current_: LINKED_LIST_ANY; i: INTEGER) is
		external
			"IL static signature (LINKED_LIST_ANY, System.Int32): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$go_i_th"
		end

	infix "@" (k: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.LINKED_LIST_ANY"
		alias
			"infix "@""
		end

	frozen ec_illegal_36_ec_illegal_36_isfirst (current_: LINKED_LIST_ANY): BOOLEAN is
		external
			"IL static signature (LINKED_LIST_ANY): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"$$isfirst"
		end

	frozen ec_illegal_36_ec_illegal_36_previous (current_: LINKED_LIST_ANY): LINKABLE_ANY is
		external
			"IL static signature (LINKED_LIST_ANY): LINKABLE_ANY use Implementation.LINKED_LIST_ANY"
		alias
			"$$previous"
		end

	linear_representation: LINEAR_ANY is
		external
			"IL signature (): LINEAR_ANY use Implementation.LINKED_LIST_ANY"
		alias
			"linear_representation"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.LINKED_LIST_ANY"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.LINKED_LIST_ANY"
		alias
			"default"
		end

	a_set_active (active2: LINKABLE_ANY) is
		external
			"IL signature (LINKABLE_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"_set_active"
		end

	frozen ec_illegal_36_ec_illegal_36_cleanup_after_remove (current_: LINKED_LIST_ANY; v: LINKABLE_ANY) is
		external
			"IL static signature (LINKED_LIST_ANY, LINKABLE_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$cleanup_after_remove"
		end

	frozen ec_illegal_36_ec_illegal_36_cursor (current_: LINKED_LIST_ANY): CURSOR is
		external
			"IL static signature (LINKED_LIST_ANY): CURSOR use Implementation.LINKED_LIST_ANY"
		alias
			"$$cursor"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"is_equal"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"compare_references"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"full"
		end

	duplicate (n: INTEGER): CHAIN_ANY is
		external
			"IL signature (System.Int32): CHAIN_ANY use Implementation.LINKED_LIST_ANY"
		alias
			"duplicate"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"print"
		end

	sequential_search (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"sequential_search"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"valid_index"
		end

	internal_wipe_out is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"internal_wipe_out"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: LINKED_LIST_ANY; i: INTEGER) is
		external
			"IL static signature (LINKED_LIST_ANY, System.Int32): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$move"
		end

	back is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"back"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"exhausted"
		end

	replace (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"replace"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"equal"
		end

	cursor: CURSOR is
		external
			"IL signature (): CURSOR use Implementation.LINKED_LIST_ANY"
		alias
			"cursor"
		end

	extend (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"extend"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.LINKED_LIST_ANY"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_full (current_: LINKED_LIST_ANY): BOOLEAN is
		external
			"IL static signature (LINKED_LIST_ANY): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"$$full"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"writable"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"prunable"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"same_type"
		end

	frozen ec_illegal_36_ec_illegal_36_first (current_: LINKED_LIST_ANY): ANY is
		external
			"IL static signature (LINKED_LIST_ANY): ANY use Implementation.LINKED_LIST_ANY"
		alias
			"$$first"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_back (current_: LINKED_LIST_ANY) is
		external
			"IL static signature (LINKED_LIST_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$back"
		end

	previous: LINKABLE_ANY is
		external
			"IL signature (): LINKABLE_ANY use Implementation.LINKED_LIST_ANY"
		alias
			"previous"
		end

	count_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.LINKED_LIST_ANY"
		alias
			"count"
		end

	frozen ec_illegal_36_ec_illegal_36_last_element (current_: LINKED_LIST_ANY): LINKABLE_ANY is
		external
			"IL static signature (LINKED_LIST_ANY): LINKABLE_ANY use Implementation.LINKED_LIST_ANY"
		alias
			"$$last_element"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"make"
		end

	frozen ec_illegal_36_ec_illegal_36_new_chain (current_: LINKED_LIST_ANY): LINKED_LIST_ANY is
		external
			"IL static signature (LINKED_LIST_ANY): LINKED_LIST_ANY use Implementation.LINKED_LIST_ANY"
		alias
			"$$new_chain"
		end

	frozen ec_illegal_36_ec_illegal_36_off (current_: LINKED_LIST_ANY): BOOLEAN is
		external
			"IL static signature (LINKED_LIST_ANY): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"$$off"
		end

	frozen ec_illegal_36_ec_illegal_36_index (current_: LINKED_LIST_ANY): INTEGER is
		external
			"IL static signature (LINKED_LIST_ANY): System.Int32 use Implementation.LINKED_LIST_ANY"
		alias
			"$$index"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"is_empty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"Equals"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"_set_count"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"islast"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"deep_equal"
		end

	put_left (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"put_left"
		end

	sequential_has (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.LINKED_LIST_ANY"
		alias
			"sequential_has"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.LINKED_LIST_ANY"
		alias
			"standard_clone"
		end

	sequence_put (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"sequence_put"
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: LINKED_LIST_ANY; v: ANY) is
		external
			"IL static signature (LINKED_LIST_ANY, ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$extend"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"default_rescue"
		end

	index: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.LINKED_LIST_ANY"
		alias
			"index"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.LINKED_LIST_ANY"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.LINKED_LIST_ANY"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"internal_copy"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"_set_object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_put_left (current_: LINKED_LIST_ANY; v: ANY) is
		external
			"IL static signature (LINKED_LIST_ANY, ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$put_left"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.LINKED_LIST_ANY"
		alias
			"ToString"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"wipe_out"
		end

	frozen ec_illegal_36_ec_illegal_36_copy (current_: LINKED_LIST_ANY; other: LINKED_LIST_ANY) is
		external
			"IL static signature (LINKED_LIST_ANY, LINKED_LIST_ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"$$copy"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"deep_copy"
		end

	search (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"search"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.LINKED_LIST_ANY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_LINKED_LIST_ANY
