indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ARRAYED_LIST_ANY"

external class
	IMPLEMENTATION_ARRAYED_LIST_ANY

inherit
	BOX_ANY
	CURSOR_STRUCTURE_ANY
		rename
			item as item_any,
			occurrences as occurrences_any
		end
	SEQUENCE_ANY
		rename
			item as item_any,
			occurrences as occurrences_any,
			index as index_int32,
			count as count_int32
		end
	LINEAR_ANY
		rename
			item as item_any,
			occurrences as occurrences_any,
			index as index_int32
		end
	BOUNDED_ANY
		rename
			count as count_int32
		end
	ACTIVE_ANY
		rename
			item as item_any,
			occurrences as occurrences_any
		end
	RESIZABLE_ANY
		rename
			count as count_int32
		end
	TABLE_ANY_INT32
		rename
			occurrences as occurrences_any,
			infix "@" as infix "@"_int32,
			put_any_int32 as put_any_int322,
			valid_key as array_valid_index,
			item as item_int322
		end
	DYNAMIC_CHAIN_ANY
		rename
			item as item_any,
			occurrences as occurrences_any,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_any_int32 as put_any_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	CONTAINER_ANY
	TO_SPECIAL_ANY
		rename
			infix "@" as infix "@"_int32,
			put as put_any_int322,
			valid_index as array_valid_index,
			item as item_int322
		end
	LIST_ANY
		rename
			item as item_any,
			occurrences as occurrences_any,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_any_int32 as put_any_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	INDEXABLE_ANY_INT32
		rename
			occurrences as occurrences_any,
			infix "@" as infix "@"_int32,
			put_any_int32 as put_any_int322,
			valid_key as array_valid_index,
			item as item_int322
		end
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	CHAIN_ANY
		rename
			item as item_any,
			occurrences as occurrences_any,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_any_int32 as put_any_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	UNBOUNDED_ANY
		rename
			count as count_int32
		end
	TRAVERSABLE_ANY
		rename
			item as item_any
		end
	DYNAMIC_LIST_ANY
		rename
			item as item_any,
			occurrences as occurrences_any,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_any_int32 as put_any_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	BAG_ANY
		rename
			occurrences as occurrences_any
		end
	ARRAY_ANY
		rename
			occurrences as occurrences_any,
			infix "@" as infix "@"_int32,
			count as count_int32,
			put_any_int32 as put_any_int322,
			valid_key as array_valid_index,
			valid_index as array_valid_index,
			item_int32 as item_int322,
			item as item_int322,
			force as force_any_int32,
			make as array_make
		end
	ARRAYED_LIST_ANY
		rename
			item as item_any,
			occurrences as occurrences_any,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_any_int32 as put_any_int322,
			valid_key as array_valid_index,
			valid_index as array_valid_index,
			item_int32 as item_int322,
			make as array_make
		end
	COLLECTION_ANY
	BILINEAR_ANY
		rename
			item as item_any,
			occurrences as occurrences_any,
			index as index_int32
		end
	FINITE_ANY
		rename
			count as count_int32
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.ARRAYED_LIST_ANY"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_upper: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$upper"
		end

	frozen ec_illegal_36_ec_illegal_36_lower: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$lower"
		end

	frozen ec_illegal_36_ec_illegal_36_count: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$count"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_area: SPECIAL_ANY is
		external
			"IL field signature :SPECIAL_ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$area"
		end

	frozen ec_illegal_36_ec_illegal_36_index: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$index"
		end

feature -- Basic Operations

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"conforms_to"
		end

	go_to (p: CURSOR) is
		external
			"IL signature (CURSOR): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_back (current_: ARRAYED_LIST_ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$back"
		end

	make_filled (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"make_filled"
		end

	array_make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"array_make"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"object_comparison"
		end

	sequential_index_of (v: ANY; i: INTEGER): INTEGER is
		external
			"IL signature (ANY, System.Int32): System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"sequential_index_of"
		end

	remove_left is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"remove_left"
		end

	growth_percentage: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"growth_percentage"
		end

	additional_space: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"additional_space"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAYED_LIST_ANY"
		alias
			"____class_name"
		end

	array_count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"array_count"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"move"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: ARRAYED_LIST_ANY; n: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_ANY, System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$make"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"standard_equal"
		end

	set_area (other: SPECIAL_ANY) is
		external
			"IL signature (SPECIAL_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"set_area"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ARRAYED_LIST_ANY"
		alias
			"operating_environment"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"changeable_comparison_criterion"
		end

	subcopy (other: ARRAY_ANY; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL signature (ARRAY_ANY, System.Int32, System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"subcopy"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"auto_resize"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: ARRAYED_LIST_ANY; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_ANY, System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$move"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"same_type"
		end

	replace (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"replace"
		end

	sequential_search (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"sequential_search"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_array (current_: ARRAYED_LIST_ANY; a: ARRAY_ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY, ARRAY_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: ARRAYED_LIST_ANY; v: ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY, ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$extend"
		end

	upper: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"upper"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"do_if"
		end

	put_any_int322 (v: ANY; i: INTEGER) is
		external
			"IL signature (ANY, System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"put_i_th"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ARRAYED_LIST_ANY"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_forth (current_: ARRAYED_LIST_ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$forth"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"_set_index"
		end

	all_default: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"all_default"
		end

	cursor: CURSOR is
		external
			"IL signature (): CURSOR use Implementation.ARRAYED_LIST_ANY"
		alias
			"cursor"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"standard_is_equal"
		end

	linear_representation: LINEAR_ANY is
		external
			"IL signature (): LINEAR_ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"linear_representation"
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"clear_all"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"compare_objects"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all (current_: ARRAYED_LIST_ANY; v: ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY, ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$prune_all"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"exhausted"
		end

	frozen ec_illegal_36_ec_illegal_36_first (current_: ARRAYED_LIST_ANY): ANY is
		external
			"IL static signature (ARRAYED_LIST_ANY): ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$first"
		end

	has (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"has"
		end

	put_left (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"put_left"
		end

	frozen ec_illegal_36_ec_illegal_36_put_front (current_: ARRAYED_LIST_ANY; v: ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY, ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$put_front"
		end

	frozen ec_illegal_36_ec_illegal_36_duplicate (current_: ARRAYED_LIST_ANY; n: INTEGER): ARRAYED_LIST_ANY is
		external
			"IL static signature (ARRAYED_LIST_ANY, System.Int32): ARRAYED_LIST_ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$duplicate"
		end

	sequence_put (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"sequence_put"
		end

	prune (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"prune"
		end

	frozen ec_illegal_36_ec_illegal_36_cursor (current_: ARRAYED_LIST_ANY): CURSOR is
		external
			"IL static signature (ARRAYED_LIST_ANY): CURSOR use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$cursor"
		end

	grow (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"grow"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"writable"
		end

	is_inserted (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"is_inserted"
		end

	automatic_grow is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"automatic_grow"
		end

	frozen ec_illegal_36_ec_illegal_36_go_to (current_: ARRAYED_LIST_ANY; p: CURSOR) is
		external
			"IL static signature (ARRAYED_LIST_ANY, CURSOR): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: ARRAYED_LIST_ANY): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_ANY): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$prunable"
		end

	make_from_array (a: ARRAY_ANY) is
		external
			"IL signature (ARRAY_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_make_filled (current_: ARRAYED_LIST_ANY; n: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_ANY, System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$make_filled"
		end

	item_any: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"item"
		end

	array_index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_ANY"
		alias
			"array_index_set"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ARRAYED_LIST_ANY"
		alias
			"default_pointer"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"_set_lower"
		end

	bag_put (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"bag_put"
		end

	enter (v: ANY; i: INTEGER) is
		external
			"IL signature (ANY, System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"enter"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"default_rescue"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"_set_upper"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: ARRAYED_LIST_ANY; v: ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY, ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$prune"
		end

	frozen ec_illegal_36_ec_illegal_36_array_count (current_: ARRAYED_LIST_ANY): INTEGER is
		external
			"IL static signature (ARRAYED_LIST_ANY): System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$array_count"
		end

	frozen ec_illegal_36_ec_illegal_36_set_count (current_: ARRAYED_LIST_ANY; new_count: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_ANY, System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$set_count"
		end

	sequential_has (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"sequential_has"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"islast"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: ARRAYED_LIST_ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$finish"
		end

	frozen ec_illegal_36_ec_illegal_36_put_right (current_: ARRAYED_LIST_ANY; v: ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY, ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$put_right"
		end

	merge_right (other: DYNAMIC_CHAIN_ANY) is
		external
			"IL signature (DYNAMIC_CHAIN_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"merge_right"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_ANY"
		alias
			"tagged_out"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_ANY is
		external
			"IL signature (System.Int32, System.Int32): ARRAY_ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"subarray"
		end

	force_any_int32 (v: ANY; i: INTEGER) is
		external
			"IL signature (ANY, System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"force_i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_new_chain (current_: ARRAYED_LIST_ANY): ARRAYED_LIST_ANY is
		external
			"IL static signature (ARRAYED_LIST_ANY): ARRAYED_LIST_ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$new_chain"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"start"
		end

	insert (v: ANY; pos: INTEGER) is
		external
			"IL signature (ANY, System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"insert"
		end

	index_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"index"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: ARRAYED_LIST_ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$remove"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: ARRAYED_LIST_ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$wipe_out"
		end

	fill (other: CONTAINER_ANY) is
		external
			"IL signature (CONTAINER_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"fill"
		end

	frozen ec_illegal_36_ec_illegal_36_is_inserted (current_: ARRAYED_LIST_ANY; v: ANY): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$is_inserted"
		end

	new_chain: DYNAMIC_CHAIN_ANY is
		external
			"IL signature (): DYNAMIC_CHAIN_ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"new_chain"
		end

	valid_index_set: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"valid_index_set"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"_set_count"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"_set_object_comparison"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"deep_copy"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"wipe_out"
		end

	a_set_area (area2: SPECIAL_ANY) is
		external
			"IL signature (SPECIAL_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"_set_area"
		end

	capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_force (current_: ARRAYED_LIST_ANY; v: ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY, ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$force"
		end

	count_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"count"
		end

	occurrences_any (v: ANY): INTEGER is
		external
			"IL signature (ANY): System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"occurrences"
		end

	infix "@"_int32 (i: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"infix "@""
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"do_all"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"do_nothing"
		end

	forth is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"forth"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"prunable"
		end

	prune_all (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"prune_all"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"clone"
		end

	duplicate (n: INTEGER): CHAIN_ANY is
		external
			"IL signature (System.Int32): CHAIN_ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"duplicate"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: ARRAYED_LIST_ANY; i: INTEGER): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_ANY, System.Int32): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$valid_index"
		end

	put_front (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"put_front"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"equal"
		end

	discard_items is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"discard_items"
		end

	frozen ec_illegal_36_ec_illegal_36_put_left (current_: ARRAYED_LIST_ANY; v: ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY, ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$put_left"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAYED_LIST_ANY"
		alias
			"ToString"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"compare_references"
		end

	to_c: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"to_c"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"valid_cursor_index"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"go_i_th"
		end

	area: SPECIAL_ANY is
		external
			"IL signature (): SPECIAL_ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"area"
		end

	frozen ec_illegal_36_ec_illegal_36_last (current_: ARRAYED_LIST_ANY): ANY is
		external
			"IL static signature (ARRAYED_LIST_ANY): ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$last"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"Equals"
		end

	empty_area: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"empty_area"
		end

	item_int322 (i: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"i_th"
		end

	array_valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"array_valid_index"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_ANY"
		alias
			"out"
		end

	make_area (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"make_area"
		end

	force (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"force"
		end

	chain_wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"chain_wipe_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"internal_clone"
		end

	merge_left (other: DYNAMIC_CHAIN_ANY) is
		external
			"IL signature (DYNAMIC_CHAIN_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"merge_left"
		end

	frozen ec_illegal_36_ec_illegal_36_replace (current_: ARRAYED_LIST_ANY; v: ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY, ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$replace"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"swap"
		end

	remove_right is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"remove_right"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_right (current_: ARRAYED_LIST_ANY; other: ARRAYED_LIST_ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY, ARRAYED_LIST_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$merge_right"
		end

	set_count (new_count: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"set_count"
		end

	same_items (other: ARRAY_ANY): BOOLEAN is
		external
			"IL signature (ARRAY_ANY): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"same_items"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"deep_equal"
		end

	put_right (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"put_right"
		end

	frozen ec_illegal_36_ec_illegal_36_array_index_set (current_: ARRAYED_LIST_ANY): INTEGER_INTERVAL is
		external
			"IL static signature (ARRAYED_LIST_ANY): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$array_index_set"
		end

	make_int32 (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"make"
		end

	search (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"search"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: ARRAYED_LIST_ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$start"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"standard_copy"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"for_all"
		end

	frozen ec_illegal_36_ec_illegal_36_swap (current_: ARRAYED_LIST_ANY; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_ANY, System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$swap"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor (current_: ARRAYED_LIST_ANY; p: CURSOR): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_ANY, CURSOR): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$valid_cursor"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_left (current_: ARRAYED_LIST_ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$remove_left"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"GetHashCode"
		end

	index_of (v: ANY; i: INTEGER): INTEGER is
		external
			"IL signature (ANY, System.Int32): System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"index_of"
		end

	all_cleared: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"all_cleared"
		end

	minimal_increase: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"minimal_increase"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"there_exists"
		end

	put (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"put"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"after"
		end

	resizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"resizable"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"before"
		end

	extend (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"extend"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_right (current_: ARRAYED_LIST_ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$remove_right"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"default"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_ANY"
		alias
			"generating_type"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"extendible"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"finish"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"isfirst"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_ANY"
		alias
			"index_set"
		end

	sequential_occurrences (v: ANY): INTEGER is
		external
			"IL signature (ANY): System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"sequential_occurrences"
		end

	entry (i: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"entry"
		end

	lower: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_ANY"
		alias
			"lower"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"full"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: ARRAYED_LIST_ANY): ANY is
		external
			"IL static signature (ARRAYED_LIST_ANY): ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$item"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"resize"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"print"
		end

	last: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"last"
		end

	valid_index_int32 (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"valid_index"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"remove"
		end

	frozen ec_illegal_36_ec_illegal_36_go_i_th (current_: ARRAYED_LIST_ANY; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_ANY, System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$go_i_th"
		end

	to_cil: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use Implementation.ARRAYED_LIST_ANY"
		alias
			"to_cil"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"copy"
		end

	first: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_ANY"
		alias
			"first"
		end

	frozen ec_illegal_36_ec_illegal_36_full (current_: ARRAYED_LIST_ANY): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_ANY): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$full"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"internal_copy"
		end

	back is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"back"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"is_empty"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_left (current_: ARRAYED_LIST_ANY; other: ARRAYED_LIST_ANY) is
		external
			"IL static signature (ARRAYED_LIST_ANY, ARRAYED_LIST_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$merge_left"
		end

	append (s: SEQUENCE_ANY) is
		external
			"IL signature (SEQUENCE_ANY): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"append"
		end

	frozen ec_illegal_36_ec_illegal_36_insert (current_: ARRAYED_LIST_ANY; v: ANY; pos: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_ANY, ANY, System.Int32): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"$$insert"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"readable"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_ANY"
		alias
			"generator"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL signature (CURSOR): System.Boolean use Implementation.ARRAYED_LIST_ANY"
		alias
			"valid_cursor"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_ANY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ARRAYED_LIST_ANY
