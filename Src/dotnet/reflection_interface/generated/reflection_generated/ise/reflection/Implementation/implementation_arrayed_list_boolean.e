indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ARRAYED_LIST_BOOLEAN"

external class
	IMPLEMENTATION_ARRAYED_LIST_BOOLEAN

inherit
	ACTIVE_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean
		end
	BOX_BOOLEAN
	INDEXABLE_BOOLEAN_INT32
		rename
			occurrences as occurrences_boolean,
			infix "@" as infix "@"_int32,
			put_boolean_int32 as put_boolean_int322,
			valid_key as array_valid_index,
			item as item_int322
		end
	SEQUENCE_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean,
			index as index_int32,
			count as count_int32
		end
	LINEAR_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean,
			index as index_int32
		end
	ARRAYED_LIST_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_boolean_int32 as put_boolean_int322,
			valid_key as array_valid_index,
			valid_index as array_valid_index,
			item_int32 as item_int322,
			make as array_make
		end
	CONTAINER_BOOLEAN
	UNBOUNDED_BOOLEAN
		rename
			count as count_int32
		end
	BILINEAR_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean,
			index as index_int32
		end
	TRAVERSABLE_BOOLEAN
		rename
			item as item_boolean
		end
	TO_SPECIAL_BOOLEAN
		rename
			infix "@" as infix "@"_int32,
			put as put_boolean_int322,
			valid_index as array_valid_index,
			item as item_int322
		end
	BOUNDED_BOOLEAN
		rename
			count as count_int32
		end
	DYNAMIC_CHAIN_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_boolean_int32 as put_boolean_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	FINITE_BOOLEAN
		rename
			count as count_int32
		end
	BAG_BOOLEAN
		rename
			occurrences as occurrences_boolean
		end
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	RESIZABLE_BOOLEAN
		rename
			count as count_int32
		end
	DYNAMIC_LIST_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_boolean_int32 as put_boolean_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	TABLE_BOOLEAN_INT32
		rename
			occurrences as occurrences_boolean,
			infix "@" as infix "@"_int32,
			put_boolean_int32 as put_boolean_int322,
			valid_key as array_valid_index,
			item as item_int322
		end
	ARRAY_BOOLEAN
		rename
			occurrences as occurrences_boolean,
			infix "@" as infix "@"_int32,
			count as count_int32,
			put_boolean_int32 as put_boolean_int322,
			valid_key as array_valid_index,
			valid_index as array_valid_index,
			item_int32 as item_int322,
			item as item_int322,
			force as force_boolean_int32,
			make as array_make
		end
	COLLECTION_BOOLEAN
	LIST_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_boolean_int32 as put_boolean_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	CHAIN_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean,
			infix "@" as infix "@"_int32,
			index as index_int32,
			count as count_int32,
			put_boolean_int32 as put_boolean_int322,
			valid_key as array_valid_index,
			item_int32 as item_int322
		end
	CURSOR_STRUCTURE_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.ARRAYED_LIST_BOOLEAN"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_upper: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$upper"
		end

	frozen ec_illegal_36_ec_illegal_36_lower: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$lower"
		end

	frozen ec_illegal_36_ec_illegal_36_count: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$count"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_area: SPECIAL_BOOLEAN is
		external
			"IL field signature :SPECIAL_BOOLEAN use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$area"
		end

	frozen ec_illegal_36_ec_illegal_36_index: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$index"
		end

feature -- Basic Operations

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"conforms_to"
		end

	go_to (p: CURSOR) is
		external
			"IL signature (CURSOR): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_back (current_: ARRAYED_LIST_BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$back"
		end

	make_filled (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"make_filled"
		end

	array_make (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"array_make"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"object_comparison"
		end

	sequential_index_of (v: BOOLEAN; i: INTEGER): INTEGER is
		external
			"IL signature (System.Boolean, System.Int32): System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"sequential_index_of"
		end

	entry (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"entry"
		end

	remove_left is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"remove_left"
		end

	growth_percentage: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"growth_percentage"
		end

	additional_space: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"additional_space"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"____class_name"
		end

	prune (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"prune"
		end

	move (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"move"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: ARRAYED_LIST_BOOLEAN; n: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$make"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"standard_equal"
		end

	set_area (other: SPECIAL_BOOLEAN) is
		external
			"IL signature (SPECIAL_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"set_area"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"changeable_comparison_criterion"
		end

	subcopy (other: ARRAY_BOOLEAN; start_pos: INTEGER; end_pos: INTEGER; index_pos: INTEGER) is
		external
			"IL signature (ARRAY_BOOLEAN, System.Int32, System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"subcopy"
		end

	array_count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"array_count"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: ARRAYED_LIST_BOOLEAN; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$move"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"same_type"
		end

	replace (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"replace"
		end

	sequential_search (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"sequential_search"
		end

	frozen ec_illegal_36_ec_illegal_36_make_from_array (current_: ARRAYED_LIST_BOOLEAN; a: ARRAY_BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, ARRAY_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: ARRAYED_LIST_BOOLEAN; v: BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$extend"
		end

	upper: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"upper"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"do_if"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_forth (current_: ARRAYED_LIST_BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$forth"
		end

	a_set_index (index2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"_set_index"
		end

	all_default: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"all_default"
		end

	cursor: CURSOR is
		external
			"IL signature (): CURSOR use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"cursor"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"standard_is_equal"
		end

	linear_representation: LINEAR_BOOLEAN is
		external
			"IL signature (): LINEAR_BOOLEAN use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"linear_representation"
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"clear_all"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"compare_objects"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all (current_: ARRAYED_LIST_BOOLEAN; v: BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$prune_all"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"exhausted"
		end

	frozen ec_illegal_36_ec_illegal_36_first (current_: ARRAYED_LIST_BOOLEAN): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$first"
		end

	has (v: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Boolean): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"has"
		end

	put_left (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"put_left"
		end

	frozen ec_illegal_36_ec_illegal_36_put_front (current_: ARRAYED_LIST_BOOLEAN; v: BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$put_front"
		end

	frozen ec_illegal_36_ec_illegal_36_duplicate (current_: ARRAYED_LIST_BOOLEAN; n: INTEGER): ARRAYED_LIST_BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Int32): ARRAYED_LIST_BOOLEAN use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$duplicate"
		end

	sequence_put (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"sequence_put"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"operating_environment"
		end

	frozen ec_illegal_36_ec_illegal_36_cursor (current_: ARRAYED_LIST_BOOLEAN): CURSOR is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): CURSOR use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$cursor"
		end

	grow (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"grow"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"writable"
		end

	is_inserted (v: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Boolean): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"is_inserted"
		end

	automatic_grow is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"automatic_grow"
		end

	auto_resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"auto_resize"
		end

	frozen ec_illegal_36_ec_illegal_36_go_to (current_: ARRAYED_LIST_BOOLEAN; p: CURSOR) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, CURSOR): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: ARRAYED_LIST_BOOLEAN): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$prunable"
		end

	make_from_array (a: ARRAY_BOOLEAN) is
		external
			"IL signature (ARRAY_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"make_from_array"
		end

	frozen ec_illegal_36_ec_illegal_36_make_filled (current_: ARRAYED_LIST_BOOLEAN; n: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$make_filled"
		end

	array_index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"array_index_set"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"default_pointer"
		end

	a_set_lower (lower2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"_set_lower"
		end

	bag_put (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"bag_put"
		end

	enter (v: BOOLEAN; i: INTEGER) is
		external
			"IL signature (System.Boolean, System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"enter"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"default_rescue"
		end

	a_set_upper (upper2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"_set_upper"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: ARRAYED_LIST_BOOLEAN; v: BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$prune"
		end

	frozen ec_illegal_36_ec_illegal_36_array_count (current_: ARRAYED_LIST_BOOLEAN): INTEGER is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$array_count"
		end

	frozen ec_illegal_36_ec_illegal_36_set_count (current_: ARRAYED_LIST_BOOLEAN; new_count: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$set_count"
		end

	sequential_has (v: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Boolean): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"sequential_has"
		end

	islast: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"islast"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: ARRAYED_LIST_BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$finish"
		end

	frozen ec_illegal_36_ec_illegal_36_put_right (current_: ARRAYED_LIST_BOOLEAN; v: BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$put_right"
		end

	merge_right (other: DYNAMIC_CHAIN_BOOLEAN) is
		external
			"IL signature (DYNAMIC_CHAIN_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"merge_right"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"tagged_out"
		end

	subarray (start_pos: INTEGER; end_pos: INTEGER): ARRAY_BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32): ARRAY_BOOLEAN use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"subarray"
		end

	frozen ec_illegal_36_ec_illegal_36_new_chain (current_: ARRAYED_LIST_BOOLEAN): ARRAYED_LIST_BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): ARRAYED_LIST_BOOLEAN use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$new_chain"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"start"
		end

	insert (v: BOOLEAN; pos: INTEGER) is
		external
			"IL signature (System.Boolean, System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"insert"
		end

	index_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"index"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: ARRAYED_LIST_BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$remove"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: ARRAYED_LIST_BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$wipe_out"
		end

	fill (other: CONTAINER_BOOLEAN) is
		external
			"IL signature (CONTAINER_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"fill"
		end

	frozen ec_illegal_36_ec_illegal_36_is_inserted (current_: ARRAYED_LIST_BOOLEAN; v: BOOLEAN): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Boolean): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$is_inserted"
		end

	new_chain: DYNAMIC_CHAIN_BOOLEAN is
		external
			"IL signature (): DYNAMIC_CHAIN_BOOLEAN use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"new_chain"
		end

	valid_index_set: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"valid_index_set"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"_set_count"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"_set_object_comparison"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"deep_copy"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"wipe_out"
		end

	a_set_area (area2: SPECIAL_BOOLEAN) is
		external
			"IL signature (SPECIAL_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"_set_area"
		end

	capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_force (current_: ARRAYED_LIST_BOOLEAN; v: BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$force"
		end

	count_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"count"
		end

	infix "@"_int32 (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"infix "@""
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"do_all"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"do_nothing"
		end

	forth is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"forth"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"prunable"
		end

	prune_all (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"prune_all"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"clone"
		end

	duplicate (n: INTEGER): CHAIN_BOOLEAN is
		external
			"IL signature (System.Int32): CHAIN_BOOLEAN use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"duplicate"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_index (current_: ARRAYED_LIST_BOOLEAN; i: INTEGER): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Int32): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$valid_index"
		end

	put_front (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"put_front"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"equal"
		end

	discard_items is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"discard_items"
		end

	frozen ec_illegal_36_ec_illegal_36_put_left (current_: ARRAYED_LIST_BOOLEAN; v: BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$put_left"
		end

	occurrences_boolean (v: BOOLEAN): INTEGER is
		external
			"IL signature (System.Boolean): System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"occurrences"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"ToString"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"compare_references"
		end

	to_c: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"to_c"
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"valid_cursor_index"
		end

	go_i_th (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"go_i_th"
		end

	area: SPECIAL_BOOLEAN is
		external
			"IL signature (): SPECIAL_BOOLEAN use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"area"
		end

	frozen ec_illegal_36_ec_illegal_36_last (current_: ARRAYED_LIST_BOOLEAN): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$last"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"Equals"
		end

	empty_area: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"empty_area"
		end

	item_int322 (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"i_th"
		end

	array_valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"array_valid_index"
		end

	put_boolean_int322 (v: BOOLEAN; i: INTEGER) is
		external
			"IL signature (System.Boolean, System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"put_i_th"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"out"
		end

	make_area (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"make_area"
		end

	item_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"item"
		end

	force (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"force"
		end

	chain_wipe_out is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"chain_wipe_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"internal_clone"
		end

	merge_left (other: DYNAMIC_CHAIN_BOOLEAN) is
		external
			"IL signature (DYNAMIC_CHAIN_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"merge_left"
		end

	frozen ec_illegal_36_ec_illegal_36_replace (current_: ARRAYED_LIST_BOOLEAN; v: BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$replace"
		end

	swap (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"swap"
		end

	remove_right is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"remove_right"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_right (current_: ARRAYED_LIST_BOOLEAN; other: ARRAYED_LIST_BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, ARRAYED_LIST_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$merge_right"
		end

	set_count (new_count: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"set_count"
		end

	same_items (other: ARRAY_BOOLEAN): BOOLEAN is
		external
			"IL signature (ARRAY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"same_items"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"deep_equal"
		end

	put_right (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"put_right"
		end

	frozen ec_illegal_36_ec_illegal_36_array_index_set (current_: ARRAYED_LIST_BOOLEAN): INTEGER_INTERVAL is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$array_index_set"
		end

	make_int32 (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"make"
		end

	search (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"search"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: ARRAYED_LIST_BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$start"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"standard_copy"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"for_all"
		end

	frozen ec_illegal_36_ec_illegal_36_swap (current_: ARRAYED_LIST_BOOLEAN; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$swap"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor (current_: ARRAYED_LIST_BOOLEAN; p: CURSOR): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, CURSOR): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$valid_cursor"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_left (current_: ARRAYED_LIST_BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$remove_left"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"GetHashCode"
		end

	index_of (v: BOOLEAN; i: INTEGER): INTEGER is
		external
			"IL signature (System.Boolean, System.Int32): System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"index_of"
		end

	all_cleared: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"all_cleared"
		end

	minimal_increase: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"minimal_increase"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"there_exists"
		end

	put (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"put"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"after"
		end

	resizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"resizable"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"before"
		end

	extend (v: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"extend"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_right (current_: ARRAYED_LIST_BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$remove_right"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"default"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"generating_type"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"extendible"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"finish"
		end

	isfirst: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"isfirst"
		end

	index_set: INTEGER_INTERVAL is
		external
			"IL signature (): INTEGER_INTERVAL use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"index_set"
		end

	sequential_occurrences (v: BOOLEAN): INTEGER is
		external
			"IL signature (System.Boolean): System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"sequential_occurrences"
		end

	force_boolean_int32 (v: BOOLEAN; i: INTEGER) is
		external
			"IL signature (System.Boolean, System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"force_i_th"
		end

	lower: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"lower"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"full"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: ARRAYED_LIST_BOOLEAN): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$item"
		end

	resize (min_index: INTEGER; max_index: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"resize"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"print"
		end

	last: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"last"
		end

	valid_index_int32 (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"valid_index"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"remove"
		end

	frozen ec_illegal_36_ec_illegal_36_go_i_th (current_: ARRAYED_LIST_BOOLEAN; i: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$go_i_th"
		end

	to_cil: NATIVE_ARRAY [BOOLEAN] is
		external
			"IL signature (): System.Boolean[] use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"to_cil"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"copy"
		end

	first: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"first"
		end

	frozen ec_illegal_36_ec_illegal_36_full (current_: ARRAYED_LIST_BOOLEAN): BOOLEAN is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$full"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"internal_copy"
		end

	back is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"back"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"is_empty"
		end

	frozen ec_illegal_36_ec_illegal_36_merge_left (current_: ARRAYED_LIST_BOOLEAN; other: ARRAYED_LIST_BOOLEAN) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, ARRAYED_LIST_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$merge_left"
		end

	append (s: SEQUENCE_BOOLEAN) is
		external
			"IL signature (SEQUENCE_BOOLEAN): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"append"
		end

	frozen ec_illegal_36_ec_illegal_36_insert (current_: ARRAYED_LIST_BOOLEAN; v: BOOLEAN; pos: INTEGER) is
		external
			"IL static signature (ARRAYED_LIST_BOOLEAN, System.Boolean, System.Int32): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"$$insert"
		end

	readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"readable"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"generator"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL signature (CURSOR): System.Boolean use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"valid_cursor"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ARRAYED_LIST_BOOLEAN"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ARRAYED_LIST_BOOLEAN
