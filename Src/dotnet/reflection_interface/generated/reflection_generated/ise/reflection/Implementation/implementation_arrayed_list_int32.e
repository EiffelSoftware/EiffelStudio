indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ARRAYED_LIST_INT32"

external class
	IMPLEMENTATION_ARRAYED_LIST_INT32

inherit
	CONTAINER_INT32
	ARRAYED_LIST_INT32
		rename
			item as item_int32,
			occurrences as occurrences_int32,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_int32_int32 as put_int32_int322,
			valid_key as array_valid_index,
			valid_index as array_valid_index,
			item_int322 as item_int3223,
			make as array_make
		end
	TO_SPECIAL_INT32
		rename
			infix "@" as infix "@"_int32,
			put as put_int32_int322,
			valid_index as array_valid_index,
			item as item_int3223
		end
	INDEXABLE_INT32_INT32
		rename
			occurrences as occurrences_int32,
			infix "@" as infix "@"_int32,
			put_int32_int32 as put_int32_int322,
			valid_key as array_valid_index,
			item as item_int3223
		end
	CURSOR_STRUCTURE_INT32
		rename
			item as item_int32,
			occurrences as occurrences_int32
		end
	FINITE_INT32
		rename
			count as count_int32
		end
	CHAIN_INT32
		rename
			item as item_int32,
			occurrences as occurrences_int32,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_int32_int32 as put_int32_int322,
			valid_key as array_valid_index,
			item_int322 as item_int3223
		end
	BOUNDED_INT32
		rename
			count as count_int32
		end
	ARRAY_INT32
		rename
			occurrences as occurrences_int32,
			infix "@" as infix "@"_int32,
			count as count_int32,
			put_int32_int32 as put_int32_int322,
			valid_key as array_valid_index,
			valid_index as array_valid_index,
			item_int32 as item_int3223,
			item as item_int3223,
			force as force_int32_int32,
			make as array_make
		end
	COLLECTION_INT32
	TABLE_INT32_INT32
		rename
			occurrences as occurrences_int32,
			infix "@" as infix "@"_int32,
			put_int32_int32 as put_int32_int322,
			valid_key as array_valid_index,
			item as item_int3223
		end
	LINEAR_INT32
		rename
			item as item_int32,
			occurrences as occurrences_int32,
			index as index_int32
		end
	RESIZABLE_INT32
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
	ACTIVE_INT32
		rename
			item as item_int32,
			occurrences as occurrences_int32
		end
	DYNAMIC_LIST_INT32
		rename
			item as item_int32,
			occurrences as occurrences_int32,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_int32_int32 as put_int32_int322,
			valid_key as array_valid_index,
			item_int322 as item_int3223
		end
	BILINEAR_INT32
		rename
			item as item_int32,
			occurrences as occurrences_int32,
			index as index_int32
		end
	DYNAMIC_CHAIN_INT32
		rename
			item as item_int32,
			occurrences as occurrences_int32,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_int32_int32 as put_int32_int322,
			valid_key as array_valid_index,
			item_int322 as item_int3223
		end
	SEQUENCE_INT32
		rename
			item as item_int32,
			occurrences as occurrences_int32,
			index as index_int32,
			count as count_int32
		end
	LIST_INT32
		rename
			item as item_int32,
			occurrences as occurrences_int32,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_int32_int32 as put_int32_int322,
			valid_key as array_valid_index,
			item_int322 as item_int3223
		end
	UNBOUNDED_INT32
		rename
			count as count_int32
		end
	BOX_INT32
	TRAVERSABLE_INT32
		rename
			item as item_int32
		end
	BAG_INT32
		rename
			occurrences as occurrences_int32
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.ARRAYED_LIST_INT32"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_upper: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$upper"
		end

	frozen ec_illegal_36_ec_illegal_36_lower: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$lower"
		end

	frozen ec_illegal_36_ec_illegal_36_count: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$count"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_area: SPECIAL_INT32 is
		external
			"IL field signature :SPECIAL_INT32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$area"
		end

	frozen ec_illegal_36_ec_illegal_36_index: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$index"
		end

feature -- Basic Operations

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"conforms_to"
		end

	go_to (p: CURSOR) is
		external
			"IL signature (CURSOR): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_back (current_: ARRAYED_LIST_INT32) is
		external
			"IL static signature (ARRAYED_LIST_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$back"
		end

	make_filled (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"make_filled"
		end

	array_make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"array_make"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"object_comparison"
		end

	sequential_index_of (v: INTEGER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"sequential_index_of"
		end

	remove_left is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"remove_left"
		end

	growth_percentage: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"growth_percentage"
		end

	additional_space: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"additional_space"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAYED_LIST_INT32"
		alias
			"____class_name"
		end

	array_count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"array_count"
		end

	put_int32_int322 (v: INTEGER; i: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"put_i_th"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"move"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: ARRAYED_LIST_INT32; n: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$make"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"standard_equal"
		end

	set_area (other: SPECIAL_INT32) is
		external
			"IL signature (SPECIAL_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"set_area"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ARRAYED_LIST_INT32"
		alias
			"operating_environment"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"changeable_comparison_criterion"
		end

	subcopy (other: ARRAY_INT32; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL signature (ARRAY_INT32, System.Int32, System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"subcopy"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"auto_resize"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: ARRAYED_LIST_INT32; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$move"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"same_type"
		end

	replace (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"replace"
		end

	sequential_search (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"sequential_search"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_array (current_: ARRAYED_LIST_INT32; a: ARRAY_INT32) is
		external
			"IL static signature (ARRAYED_LIST_INT32, ARRAY_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: ARRAYED_LIST_INT32; v: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$extend"
		end

	upper: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"upper"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"do_if"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ARRAYED_LIST_INT32"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_forth (current_: ARRAYED_LIST_INT32) is
		external
			"IL static signature (ARRAYED_LIST_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$forth"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"_set_index"
		end

	all_default: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"all_default"
		end

	cursor: CURSOR is
		external
			"IL signature (): CURSOR use Implementation.ARRAYED_LIST_INT32"
		alias
			"cursor"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"standard_is_equal"
		end

	linear_representation: LINEAR_INT32 is
		external
			"IL signature (): LINEAR_INT32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"linear_representation"
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"clear_all"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"compare_objects"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all (current_: ARRAYED_LIST_INT32; v: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$prune_all"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"exhausted"
		end

	frozen ec_illegal_36_ec_illegal_36_first (current_: ARRAYED_LIST_INT32): INTEGER is
		external
			"IL static signature (ARRAYED_LIST_INT32): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$first"
		end

	has (v: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"has"
		end

	put_left (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"put_left"
		end

	frozen ec_illegal_36_ec_illegal_36_put_front (current_: ARRAYED_LIST_INT32; v: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$put_front"
		end

	frozen ec_illegal_36_ec_illegal_36_duplicate (current_: ARRAYED_LIST_INT32; n: INTEGER): ARRAYED_LIST_INT32 is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): ARRAYED_LIST_INT32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$duplicate"
		end

	sequence_put (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"sequence_put"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_INT32 is
		external
			"IL signature (System.Int32, System.Int32): ARRAY_INT32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"subarray"
		end

	prune (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"prune"
		end

	frozen ec_illegal_36_ec_illegal_36_cursor (current_: ARRAYED_LIST_INT32): CURSOR is
		external
			"IL static signature (ARRAYED_LIST_INT32): CURSOR use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$cursor"
		end

	grow (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"grow"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"writable"
		end

	is_inserted (v: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"is_inserted"
		end

	automatic_grow is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"automatic_grow"
		end

	frozen ec_illegal_36_ec_illegal_36_go_to (current_: ARRAYED_LIST_INT32; p: CURSOR) is
		external
			"IL static signature (ARRAYED_LIST_INT32, CURSOR): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: ARRAYED_LIST_INT32): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_INT32): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$prunable"
		end

	make_from_array (a: ARRAY_INT32) is
		external
			"IL signature (ARRAY_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_make_filled (current_: ARRAYED_LIST_INT32; n: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$make_filled"
		end

	array_index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_INT32"
		alias
			"array_index_set"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ARRAYED_LIST_INT32"
		alias
			"default_pointer"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"_set_lower"
		end

	bag_put (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"bag_put"
		end

	enter (v: INTEGER; i: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"enter"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"default_rescue"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"_set_upper"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: ARRAYED_LIST_INT32; v: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$prune"
		end

	frozen ec_illegal_36_ec_illegal_36_array_count (current_: ARRAYED_LIST_INT32): INTEGER is
		external
			"IL static signature (ARRAYED_LIST_INT32): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$array_count"
		end

	frozen ec_illegal_36_ec_illegal_36_set_count (current_: ARRAYED_LIST_INT32; new_count: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$set_count"
		end

	sequential_has (v: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"sequential_has"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"islast"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: ARRAYED_LIST_INT32) is
		external
			"IL static signature (ARRAYED_LIST_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$finish"
		end

	frozen ec_illegal_36_ec_illegal_36_put_right (current_: ARRAYED_LIST_INT32; v: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$put_right"
		end

	merge_right (other: DYNAMIC_CHAIN_INT32) is
		external
			"IL signature (DYNAMIC_CHAIN_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"merge_right"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_INT32"
		alias
			"tagged_out"
		end

	force_int32_int32 (v: INTEGER; i: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"force_i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_new_chain (current_: ARRAYED_LIST_INT32): ARRAYED_LIST_INT32 is
		external
			"IL static signature (ARRAYED_LIST_INT32): ARRAYED_LIST_INT32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$new_chain"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"start"
		end

	insert (v: INTEGER; pos: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"insert"
		end

	index_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"index"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: ARRAYED_LIST_INT32) is
		external
			"IL static signature (ARRAYED_LIST_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$remove"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: ARRAYED_LIST_INT32) is
		external
			"IL static signature (ARRAYED_LIST_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$wipe_out"
		end

	fill (other: CONTAINER_INT32) is
		external
			"IL signature (CONTAINER_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"fill"
		end

	item_int3223 (i: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"i_th"
		end

	frozen ec_illegal_36_ec_illegal_36_is_inserted (current_: ARRAYED_LIST_INT32; v: INTEGER): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$is_inserted"
		end

	new_chain: DYNAMIC_CHAIN_INT32 is
		external
			"IL signature (): DYNAMIC_CHAIN_INT32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"new_chain"
		end

	valid_index_set: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"valid_index_set"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"_set_count"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"_set_object_comparison"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"deep_copy"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"wipe_out"
		end

	a_set_area (area2: SPECIAL_INT32) is
		external
			"IL signature (SPECIAL_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"_set_area"
		end

	capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_force (current_: ARRAYED_LIST_INT32; v: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$force"
		end

	count_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"count"
		end

	infix "@"_int32 (i: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"infix "@""
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"do_all"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"do_nothing"
		end

	forth is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"forth"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"prunable"
		end

	prune_all (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"prune_all"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_INT32"
		alias
			"clone"
		end

	duplicate (n: INTEGER): CHAIN_INT32 is
		external
			"IL signature (System.Int32): CHAIN_INT32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"duplicate"
		end

	item_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"item"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: ARRAYED_LIST_INT32; i: INTEGER): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$valid_index"
		end

	put_front (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"put_front"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"equal"
		end

	discard_items is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"discard_items"
		end

	frozen ec_illegal_36_ec_illegal_36_put_left (current_: ARRAYED_LIST_INT32; v: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$put_left"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAYED_LIST_INT32"
		alias
			"ToString"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"compare_references"
		end

	to_c: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_INT32"
		alias
			"to_c"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"valid_cursor_index"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"go_i_th"
		end

	area: SPECIAL_INT32 is
		external
			"IL signature (): SPECIAL_INT32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"area"
		end

	frozen ec_illegal_36_ec_illegal_36_last (current_: ARRAYED_LIST_INT32): INTEGER is
		external
			"IL static signature (ARRAYED_LIST_INT32): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$last"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"Equals"
		end

	empty_area: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"empty_area"
		end

	array_valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"array_valid_index"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_INT32"
		alias
			"out"
		end

	make_area (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"make_area"
		end

	force (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"force"
		end

	chain_wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"chain_wipe_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_INT32"
		alias
			"internal_clone"
		end

	merge_left (other: DYNAMIC_CHAIN_INT32) is
		external
			"IL signature (DYNAMIC_CHAIN_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"merge_left"
		end

	frozen ec_illegal_36_ec_illegal_36_replace (current_: ARRAYED_LIST_INT32; v: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$replace"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"swap"
		end

	remove_right is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"remove_right"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_right (current_: ARRAYED_LIST_INT32; other: ARRAYED_LIST_INT32) is
		external
			"IL static signature (ARRAYED_LIST_INT32, ARRAYED_LIST_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$merge_right"
		end

	set_count (new_count: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"set_count"
		end

	same_items (other: ARRAY_INT32): BOOLEAN is
		external
			"IL signature (ARRAY_INT32): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"same_items"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"deep_equal"
		end

	put_right (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"put_right"
		end

	frozen ec_illegal_36_ec_illegal_36_array_index_set (current_: ARRAYED_LIST_INT32): INTEGER_INTERVAL is
		external
			"IL static signature (ARRAYED_LIST_INT32): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$array_index_set"
		end

	make_int32 (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"make"
		end

	search (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"search"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: ARRAYED_LIST_INT32) is
		external
			"IL static signature (ARRAYED_LIST_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$start"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"standard_copy"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"for_all"
		end

	frozen ec_illegal_36_ec_illegal_36_swap (current_: ARRAYED_LIST_INT32; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$swap"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor (current_: ARRAYED_LIST_INT32; p: CURSOR): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_INT32, CURSOR): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$valid_cursor"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_left (current_: ARRAYED_LIST_INT32) is
		external
			"IL static signature (ARRAYED_LIST_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$remove_left"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_INT32"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_right (current_: ARRAYED_LIST_INT32) is
		external
			"IL static signature (ARRAYED_LIST_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$remove_right"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"GetHashCode"
		end

	index_of (v: INTEGER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"index_of"
		end

	all_cleared: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"all_cleared"
		end

	minimal_increase: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"minimal_increase"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"there_exists"
		end

	put (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"put"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"after"
		end

	resizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"resizable"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"before"
		end

	extend (v: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"extend"
		end

	occurrences_int32 (v: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"occurrences"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_INT32"
		alias
			"default"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_INT32"
		alias
			"generating_type"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"extendible"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"finish"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"isfirst"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_INT32"
		alias
			"index_set"
		end

	sequential_occurrences (v: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"sequential_occurrences"
		end

	entry (i: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"entry"
		end

	lower: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"lower"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"full"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: ARRAYED_LIST_INT32): INTEGER is
		external
			"IL static signature (ARRAYED_LIST_INT32): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$item"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"resize"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_INT32"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"print"
		end

	last: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"last"
		end

	valid_index_int32 (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"valid_index"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"remove"
		end

	frozen ec_illegal_36_ec_illegal_36_go_i_th (current_: ARRAYED_LIST_INT32; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$go_i_th"
		end

	to_cil: NATIVE_ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use Implementation.ARRAYED_LIST_INT32"
		alias
			"to_cil"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"copy"
		end

	first: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_INT32"
		alias
			"first"
		end

	frozen ec_illegal_36_ec_illegal_36_full (current_: ARRAYED_LIST_INT32): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_INT32): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$full"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"internal_copy"
		end

	back is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"back"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"is_empty"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_left (current_: ARRAYED_LIST_INT32; other: ARRAYED_LIST_INT32) is
		external
			"IL static signature (ARRAYED_LIST_INT32, ARRAYED_LIST_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$merge_left"
		end

	append (s: SEQUENCE_INT32) is
		external
			"IL signature (SEQUENCE_INT32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"append"
		end

	frozen ec_illegal_36_ec_illegal_36_insert (current_: ARRAYED_LIST_INT32; v: INTEGER; pos: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_INT32, System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"$$insert"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"readable"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_INT32"
		alias
			"generator"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL signature (CURSOR): System.Boolean use Implementation.ARRAYED_LIST_INT32"
		alias
			"valid_cursor"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_INT32"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ARRAYED_LIST_INT32
