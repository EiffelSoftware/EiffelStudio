indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ARRAYED_LIST_SINGLE"

external class
	IMPLEMENTATION_ARRAYED_LIST_SINGLE

inherit
	LINEAR_SINGLE
		rename
			item as item_single,
			occurrences as occurrences_single,
			index as index_int32
		end
	SEQUENCE_SINGLE
		rename
			item as item_single,
			occurrences as occurrences_single,
			index as index_int32,
			count as count_int32
		end
	CONTAINER_SINGLE
	BAG_SINGLE
		rename
			occurrences as occurrences_single
		end
	COLLECTION_SINGLE
	DYNAMIC_CHAIN_SINGLE
		rename
			item as item_single,
			occurrences as occurrences_single,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_single_int32 as put_single_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	FINITE_SINGLE
		rename
			count as count_int32
		end
	BOX_SINGLE
	BOUNDED_SINGLE
		rename
			count as count_int32
		end
	RESIZABLE_SINGLE
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
	INDEXABLE_SINGLE_INT32
		rename
			occurrences as occurrences_single,
			infix "@" as infix "@"_int32,
			put_single_int32 as put_single_int322,
			valid_key as array_valid_index,
			item as item_int322
		end
	TABLE_SINGLE_INT32
		rename
			occurrences as occurrences_single,
			infix "@" as infix "@"_int32,
			put_single_int32 as put_single_int322,
			valid_key as array_valid_index,
			item as item_int322
		end
	ACTIVE_SINGLE
		rename
			item as item_single,
			occurrences as occurrences_single
		end
	UNBOUNDED_SINGLE
		rename
			count as count_int32
		end
	LIST_SINGLE
		rename
			item as item_single,
			occurrences as occurrences_single,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_single_int32 as put_single_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	CURSOR_STRUCTURE_SINGLE
		rename
			item as item_single,
			occurrences as occurrences_single
		end
	TRAVERSABLE_SINGLE
		rename
			item as item_single
		end
	TO_SPECIAL_SINGLE
		rename
			infix "@" as infix "@"_int32,
			put as put_single_int322,
			valid_index as array_valid_index,
			item as item_int322
		end
	CHAIN_SINGLE
		rename
			item as item_single,
			occurrences as occurrences_single,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_single_int32 as put_single_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	ARRAYED_LIST_SINGLE
		rename
			item as item_single,
			occurrences as occurrences_single,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_single_int32 as put_single_int322,
			valid_key as array_valid_index,
			valid_index as array_valid_index,
			item_int32 as item_int322,
			make as array_make
		end
	ARRAY_SINGLE
		rename
			occurrences as occurrences_single,
			infix "@" as infix "@"_int32,
			count as count_int32,
			put_single_int32 as put_single_int322,
			valid_key as array_valid_index,
			valid_index as array_valid_index,
			item_int32 as item_int322,
			item as item_int322,
			force as force_single_int32,
			make as array_make
		end
	BILINEAR_SINGLE
		rename
			item as item_single,
			occurrences as occurrences_single,
			index as index_int32
		end
	DYNAMIC_LIST_SINGLE
		rename
			item as item_single,
			occurrences as occurrences_single,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_single_int32 as put_single_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.ARRAYED_LIST_SINGLE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_upper: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$upper"
		end

	frozen ec_illegal_36_ec_illegal_36_lower: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$lower"
		end

	frozen ec_illegal_36_ec_illegal_36_count: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$count"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_area: SPECIAL_SINGLE is
		external
			"IL field signature :SPECIAL_SINGLE use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$area"
		end

	frozen ec_illegal_36_ec_illegal_36_index: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$index"
		end

feature -- Basic Operations

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"conforms_to"
		end

	go_to (p: CURSOR) is
		external
			"IL signature (CURSOR): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_back (current_: ARRAYED_LIST_SINGLE) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$back"
		end

	make_filled (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"make_filled"
		end

	array_make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"array_make"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"object_comparison"
		end

	sequential_index_of (v: REAL; i: INTEGER): INTEGER is
		external
			"IL signature (System.Single, System.Int32): System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"sequential_index_of"
		end

	remove_left is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"remove_left"
		end

	growth_percentage: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"growth_percentage"
		end

	additional_space: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"additional_space"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"____class_name"
		end

	array_count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"array_count"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"move"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: ARRAYED_LIST_SINGLE; n: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$make"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"standard_equal"
		end

	set_area (other: SPECIAL_SINGLE) is
		external
			"IL signature (SPECIAL_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"set_area"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"operating_environment"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"changeable_comparison_criterion"
		end

	subcopy (other: ARRAY_SINGLE; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL signature (ARRAY_SINGLE, System.Int32, System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"subcopy"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"auto_resize"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: ARRAYED_LIST_SINGLE; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$move"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"same_type"
		end

	replace (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"replace"
		end

	sequential_search (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"sequential_search"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_array (current_: ARRAYED_LIST_SINGLE; a: ARRAY_SINGLE) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, ARRAY_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: ARRAYED_LIST_SINGLE; v: REAL) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$extend"
		end

	upper: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"upper"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"do_if"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_forth (current_: ARRAYED_LIST_SINGLE) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$forth"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"_set_index"
		end

	all_default: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"all_default"
		end

	cursor: CURSOR is
		external
			"IL signature (): CURSOR use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"cursor"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"standard_is_equal"
		end

	linear_representation: LINEAR_SINGLE is
		external
			"IL signature (): LINEAR_SINGLE use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"linear_representation"
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"clear_all"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"compare_objects"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all (current_: ARRAYED_LIST_SINGLE; v: REAL) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$prune_all"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"exhausted"
		end

	frozen ec_illegal_36_ec_illegal_36_first (current_: ARRAYED_LIST_SINGLE): REAL is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): System.Single use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$first"
		end

	has (v: REAL): BOOLEAN is
		external
			"IL signature (System.Single): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"has"
		end

	put_left (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"put_left"
		end

	frozen ec_illegal_36_ec_illegal_36_put_front (current_: ARRAYED_LIST_SINGLE; v: REAL) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$put_front"
		end

	frozen ec_illegal_36_ec_illegal_36_duplicate (current_: ARRAYED_LIST_SINGLE; n: INTEGER): ARRAYED_LIST_SINGLE is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Int32): ARRAYED_LIST_SINGLE use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$duplicate"
		end

	sequence_put (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"sequence_put"
		end

	prune (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"prune"
		end

	frozen ec_illegal_36_ec_illegal_36_array_index_set (current_: ARRAYED_LIST_SINGLE): INTEGER_INTERVAL is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$array_index_set"
		end

	frozen ec_illegal_36_ec_illegal_36_cursor (current_: ARRAYED_LIST_SINGLE): CURSOR is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): CURSOR use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$cursor"
		end

	grow (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"grow"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"writable"
		end

	is_inserted (v: REAL): BOOLEAN is
		external
			"IL signature (System.Single): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"is_inserted"
		end

	automatic_grow is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"automatic_grow"
		end

	frozen ec_illegal_36_ec_illegal_36_go_to (current_: ARRAYED_LIST_SINGLE; p: CURSOR) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, CURSOR): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: ARRAYED_LIST_SINGLE): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$prunable"
		end

	make_from_array (a: ARRAY_SINGLE) is
		external
			"IL signature (ARRAY_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_make_filled (current_: ARRAYED_LIST_SINGLE; n: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$make_filled"
		end

	array_index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"array_index_set"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"default_pointer"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"_set_lower"
		end

	bag_put (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"bag_put"
		end

	enter (v: REAL; i: INTEGER) is
		external
			"IL signature (System.Single, System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"enter"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"default_rescue"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"_set_upper"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: ARRAYED_LIST_SINGLE; v: REAL) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$prune"
		end

	frozen ec_illegal_36_ec_illegal_36_array_count (current_: ARRAYED_LIST_SINGLE): INTEGER is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$array_count"
		end

	frozen ec_illegal_36_ec_illegal_36_set_count (current_: ARRAYED_LIST_SINGLE; new_count: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$set_count"
		end

	sequential_has (v: REAL): BOOLEAN is
		external
			"IL signature (System.Single): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"sequential_has"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"islast"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: ARRAYED_LIST_SINGLE) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$finish"
		end

	frozen ec_illegal_36_ec_illegal_36_put_right (current_: ARRAYED_LIST_SINGLE; v: REAL) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$put_right"
		end

	merge_right (other: DYNAMIC_CHAIN_SINGLE) is
		external
			"IL signature (DYNAMIC_CHAIN_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"merge_right"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"tagged_out"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_SINGLE is
		external
			"IL signature (System.Int32, System.Int32): ARRAY_SINGLE use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"subarray"
		end

	frozen ec_illegal_36_ec_illegal_36_new_chain (current_: ARRAYED_LIST_SINGLE): ARRAYED_LIST_SINGLE is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): ARRAYED_LIST_SINGLE use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$new_chain"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"start"
		end

	insert (v: REAL; pos: INTEGER) is
		external
			"IL signature (System.Single, System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"insert"
		end

	index_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"index"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: ARRAYED_LIST_SINGLE) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$remove"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: ARRAYED_LIST_SINGLE) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$wipe_out"
		end

	fill (other: CONTAINER_SINGLE) is
		external
			"IL signature (CONTAINER_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"fill"
		end

	force_single_int32 (v: REAL; i: INTEGER) is
		external
			"IL signature (System.Single, System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"force_i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_is_inserted (current_: ARRAYED_LIST_SINGLE; v: REAL): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Single): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$is_inserted"
		end

	new_chain: DYNAMIC_CHAIN_SINGLE is
		external
			"IL signature (): DYNAMIC_CHAIN_SINGLE use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"new_chain"
		end

	valid_index_set: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"valid_index_set"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"_set_count"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"_set_object_comparison"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"deep_copy"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"wipe_out"
		end

	a_set_area (area2: SPECIAL_SINGLE) is
		external
			"IL signature (SPECIAL_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"_set_area"
		end

	capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_force (current_: ARRAYED_LIST_SINGLE; v: REAL) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$force"
		end

	count_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"count"
		end

	infix "@"_int32 (i: INTEGER): REAL is
		external
			"IL signature (System.Int32): System.Single use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"infix "@""
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"do_all"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"do_nothing"
		end

	forth is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"forth"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"prunable"
		end

	prune_all (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"prune_all"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"clone"
		end

	duplicate (n: INTEGER): CHAIN_SINGLE is
		external
			"IL signature (System.Int32): CHAIN_SINGLE use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"duplicate"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: ARRAYED_LIST_SINGLE; i: INTEGER): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Int32): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$valid_index"
		end

	put_front (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"put_front"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"equal"
		end

	discard_items is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"discard_items"
		end

	frozen ec_illegal_36_ec_illegal_36_put_left (current_: ARRAYED_LIST_SINGLE; v: REAL) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$put_left"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"ToString"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"compare_references"
		end

	to_c: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"to_c"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"valid_cursor_index"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"go_i_th"
		end

	area: SPECIAL_SINGLE is
		external
			"IL signature (): SPECIAL_SINGLE use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"area"
		end

	frozen ec_illegal_36_ec_illegal_36_last (current_: ARRAYED_LIST_SINGLE): REAL is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): System.Single use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$last"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"Equals"
		end

	empty_area: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"empty_area"
		end

	item_int322 (i: INTEGER): REAL is
		external
			"IL signature (System.Int32): System.Single use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"i_th"
		end

	array_valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"array_valid_index"
		end

	item_single: REAL is
		external
			"IL signature (): System.Single use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"item"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"out"
		end

	make_area (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"make_area"
		end

	force (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"force"
		end

	chain_wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"chain_wipe_out"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"before"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"internal_clone"
		end

	merge_left (other: DYNAMIC_CHAIN_SINGLE) is
		external
			"IL signature (DYNAMIC_CHAIN_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"merge_left"
		end

	frozen ec_illegal_36_ec_illegal_36_replace (current_: ARRAYED_LIST_SINGLE; v: REAL) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$replace"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"swap"
		end

	remove_right is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"remove_right"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_right (current_: ARRAYED_LIST_SINGLE; other: ARRAYED_LIST_SINGLE) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, ARRAYED_LIST_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$merge_right"
		end

	set_count (new_count: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"set_count"
		end

	same_items (other: ARRAY_SINGLE): BOOLEAN is
		external
			"IL signature (ARRAY_SINGLE): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"same_items"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"deep_equal"
		end

	put_right (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"put_right"
		end

	occurrences_single (v: REAL): INTEGER is
		external
			"IL signature (System.Single): System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"occurrences"
		end

	make_int32 (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"make"
		end

	search (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"search"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: ARRAYED_LIST_SINGLE) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$start"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"standard_copy"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"for_all"
		end

	frozen ec_illegal_36_ec_illegal_36_swap (current_: ARRAYED_LIST_SINGLE; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$swap"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor (current_: ARRAYED_LIST_SINGLE; p: CURSOR): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, CURSOR): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$valid_cursor"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_left (current_: ARRAYED_LIST_SINGLE) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$remove_left"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"GetHashCode"
		end

	index_of (v: REAL; i: INTEGER): INTEGER is
		external
			"IL signature (System.Single, System.Int32): System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"index_of"
		end

	all_cleared: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"all_cleared"
		end

	minimal_increase: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"minimal_increase"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"there_exists"
		end

	put (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"put"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"after"
		end

	resizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"resizable"
		end

	put_single_int322 (v: REAL; i: INTEGER) is
		external
			"IL signature (System.Single, System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"put_i_th"
		end

	extend (v: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"extend"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_right (current_: ARRAYED_LIST_SINGLE) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$remove_right"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"default"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"generating_type"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"extendible"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"finish"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"isfirst"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"index_set"
		end

	sequential_occurrences (v: REAL): INTEGER is
		external
			"IL signature (System.Single): System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"sequential_occurrences"
		end

	entry (i: INTEGER): REAL is
		external
			"IL signature (System.Int32): System.Single use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"entry"
		end

	lower: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"lower"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"full"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: ARRAYED_LIST_SINGLE): REAL is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): System.Single use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$item"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"resize"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"print"
		end

	last: REAL is
		external
			"IL signature (): System.Single use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"last"
		end

	valid_index_int32 (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"valid_index"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"remove"
		end

	frozen ec_illegal_36_ec_illegal_36_go_i_th (current_: ARRAYED_LIST_SINGLE; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$go_i_th"
		end

	to_cil: NATIVE_ARRAY [REAL] is
		external
			"IL signature (): System.Single[] use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"to_cil"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"copy"
		end

	first: REAL is
		external
			"IL signature (): System.Single use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"first"
		end

	frozen ec_illegal_36_ec_illegal_36_full (current_: ARRAYED_LIST_SINGLE): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_SINGLE): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$full"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"internal_copy"
		end

	back is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"back"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"is_empty"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_left (current_: ARRAYED_LIST_SINGLE; other: ARRAYED_LIST_SINGLE) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, ARRAYED_LIST_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$merge_left"
		end

	append (s: SEQUENCE_SINGLE) is
		external
			"IL signature (SEQUENCE_SINGLE): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"append"
		end

	frozen ec_illegal_36_ec_illegal_36_insert (current_: ARRAYED_LIST_SINGLE; v: REAL; pos: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_SINGLE, System.Single, System.Int32): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"$$insert"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"readable"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"generator"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL signature (CURSOR): System.Boolean use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"valid_cursor"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_SINGLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ARRAYED_LIST_SINGLE
